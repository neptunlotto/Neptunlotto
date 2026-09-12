import { useState } from 'react';
import { calculateAge, MINIMUM_AGE } from '../utils/age';
import InlineOtpVerify from './InlineOtpVerify';

const initialForm = {
  fullName: '',
  email: '',
  phone: '',
  dob: '',
  password: '',
};

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const PHONE_MIN_DIGITS = 7;

export default function SignUpForm({ onSuccess }) {
  const [form, setForm] = useState(initialForm);
  const [touched, setTouched] = useState(false);
  const [submitError, setSubmitError] = useState('');
  const [emailVerified, setEmailVerified] = useState(false);
  const [phoneVerified, setPhoneVerified] = useState(false);

  const age = calculateAge(form.dob);
  const dobEntered = form.dob !== '';
  const isUnderage = dobEntered && age !== null && age < MINIMUM_AGE;
  const isInvalidDob = dobEntered && age === null;

  const isEmailValid = EMAIL_PATTERN.test(form.email);
  const isPhoneValid = form.phone.replace(/\D/g, '').length >= PHONE_MIN_DIGITS;

  function update(field) {
    return (e) => {
      const value = e.target.value;
      setForm((f) => ({ ...f, [field]: value }));
      // Editing a verified field invalidates that verification — the
      // OTP was sent to the old value, not the new one.
      if (field === 'email') setEmailVerified(false);
      if (field === 'phone') setPhoneVerified(false);
    };
  }

  function handleSubmit(e) {
    e.preventDefault();
    setTouched(true);
    setSubmitError('');

    if (!form.fullName || !form.email || !form.phone || !dobEntered || !form.password) {
      setSubmitError('Please fill in every field.');
      return;
    }
    if (isInvalidDob) {
      setSubmitError('Enter a valid date of birth.');
      return;
    }
    if (isUnderage) {
      setSubmitError(`You must be ${MINIMUM_AGE} or older to register.`);
      return;
    }
    if (!emailVerified || !phoneVerified) {
      setSubmitError('Verify your email and phone number before continuing.');
      return;
    }

    // Wire this up to the real registration endpoint — this UI only
    // handles client-side validation and never stores the password.
    const { password: _password, ...safeData } = form;
    onSuccess?.({ ...safeData, age });
  }

  return (
    <form onSubmit={handleSubmit} noValidate>
      <div className="nl-field">
        <label htmlFor="fullName">Full name</label>
        <input
          id="fullName"
          type="text"
          autoComplete="name"
          value={form.fullName}
          onChange={update('fullName')}
        />
      </div>

      <div className="nl-field">
        <label htmlFor="email">Email address</label>
        <div className="nl-field-with-otp">
          <input
            id="email"
            type="email"
            autoComplete="email"
            value={form.email}
            onChange={update('email')}
          />
          {emailVerified && <span className="nl-badge-verified">Verified</span>}
        </div>
        {!emailVerified && (
          <InlineOtpVerify
            key={`email-${form.email}`}
            contact={form.email}
            label="email"
            disabled={!isEmailValid}
            onVerified={() => setEmailVerified(true)}
          />
        )}
      </div>

      <div className="nl-field">
        <label htmlFor="phone">Phone number</label>
        <div className="nl-field-with-otp">
          <input
            id="phone"
            type="tel"
            autoComplete="tel"
            value={form.phone}
            onChange={update('phone')}
          />
          {phoneVerified && <span className="nl-badge-verified">Verified</span>}
        </div>
        {!phoneVerified && (
          <InlineOtpVerify
            key={`phone-${form.phone}`}
            contact={form.phone}
            label="phone"
            disabled={!isPhoneValid}
            onVerified={() => setPhoneVerified(true)}
          />
        )}
      </div>

      <div className="nl-field">
        <label htmlFor="dob">Date of birth</label>
        <input
          id="dob"
          type="date"
          autoComplete="bday"
          value={form.dob}
          max={new Date().toISOString().split('T')[0]}
          onChange={update('dob')}
        />
      </div>

      {dobEntered && !isInvalidDob && (
        <div className={`nl-age-readout${isUnderage ? ' is-blocked' : ''}`}>
          <span>Age on file</span>
          <strong>
            {age} {age === 1 ? 'year' : 'years'}
            {isUnderage ? ' — under minimum age' : ''}
          </strong>
        </div>
      )}
      {isInvalidDob && <p className="nl-error">That date doesn&apos;t look right.</p>}

      {<div className="nl-field">
        <label htmlFor="password">Password</label>
        <input
          id="password"
          type="password"
          autoComplete="new-password"
          value={form.password}
          onChange={update('password')}
        />
      </div> }

      {touched && submitError && <p className="nl-error">{submitError}</p>}

      <button
        type="submit"
        className="nl-btn nl-btn-gold nl-btn-block"
        disabled={isUnderage || !emailVerified || !phoneVerified}
      >
        Sign Up
      </button>

      <p className="nl-note">
        Registration is limited to players aged {MINIMUM_AGE}+. Verify your
        email and phone above, then ID and passport verification happens
        after this step, through our KYC provider.
      </p>
    </form>
  );
}