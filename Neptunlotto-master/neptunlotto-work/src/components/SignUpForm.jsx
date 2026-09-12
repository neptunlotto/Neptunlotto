import { useState } from 'react';

import { calculateAge, MINIMUM_AGE } from '../utils/age';

import { signupUser } from '../services/api';

import InlineOtpVerify from './InlineOtpVerify';

import PhoneInput, {
  isValidPhoneNumber,
} from 'react-phone-number-input';

import 'react-phone-number-input/style.css';

const initialForm = {
  fullName: '',
  email: '',
  phone: '',
  dob: '',
  password: '',
};

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export default function SignUpForm({ onSuccess }) {
  const [form, setForm] = useState(initialForm);
  const [touched, setTouched] = useState(false);
  const [submitError, setSubmitError] = useState('');
  const [emailVerified, setEmailVerified] = useState(false);
  const [phoneVerified, setPhoneVerified] = useState(false);

  const age = calculateAge(form.dob);

  const dobEntered = form.dob !== '';

  const isUnderage =
    dobEntered && age !== null && age < MINIMUM_AGE;

  const isInvalidDob =
    dobEntered && age === null;

  const isEmailValid =
    EMAIL_PATTERN.test(form.email);

  const isPhoneValid =
    form.phone !== '' &&
    isValidPhoneNumber(form.phone);

  function update(field) {
    return (e) => {
      const value = e.target.value;

      setForm((f) => ({
        ...f,
        [field]: value,
      }));

      // Editing a verified field invalidates that verification.
      if (field === 'email') {
        setEmailVerified(false);
      }

      if (field === 'phone') {
        setPhoneVerified(false);
      }
    };
  }

  function handlePhoneChange(value) {
    setForm((f) => ({
      ...f,
      phone: value || '',
    }));

    // Changing phone number invalidates previous verification.
    setPhoneVerified(false);
  }

  async function handleSubmit(e) {
    e.preventDefault();

    setTouched(true);
    setSubmitError('');

    // Required fields
    if (
      !form.fullName ||
      !form.email ||
      !form.phone ||
      !dobEntered ||
      !form.password
    ) {
      setSubmitError('Please fill in every field.');
      return;
    }

    // Phone validation
    if (!isPhoneValid) {
      setSubmitError('Enter a valid phone number.');
      return;
    }

    // DOB validation
    if (isInvalidDob) {
      setSubmitError('Enter a valid date of birth.');
      return;
    }

    // Age validation
    if (isUnderage) {
      setSubmitError(
        `You must be ${MINIMUM_AGE} or older to register.`
      );
      return;
    }

    // Email and phone OTP verification
    if (!emailVerified || !phoneVerified) {
      setSubmitError(
        'Verify your email and phone number before continuing.'
      );
      return;
    }

    try {
      // Send signup data to backend
      const response = await signupUser({
        name: form.fullName,
        email: form.email,
        mobile: form.phone,
        date_of_birth: form.dob,
        password: form.password,
      });

      console.log('Signup successful:', response);

      // Move to next step after successful registration
      onSuccess?.({
        ...form,
        age,
        userId: response.userId,
      });

    } catch (error) {
      console.error('Signup failed:', error);

      setSubmitError(
        error.message || 'Signup failed. Please try again.'
      );
    }
  }

  return (
    <form onSubmit={handleSubmit} noValidate>

      {/* Full Name */}
      <div className="nl-field">
        <label htmlFor="fullName">
          Full name
        </label>

        <input
          id="fullName"
          type="text"
          autoComplete="name"
          value={form.fullName}
          onChange={update('fullName')}
        />
      </div>

      {/* Email */}
      <div className="nl-field">
        <label htmlFor="email">
          Email address
        </label>

        <div className="nl-field-with-otp">
          <input
            id="email"
            type="email"
            autoComplete="email"
            value={form.email}
            onChange={update('email')}
          />

          {emailVerified && (
            <span className="nl-badge-verified">
              Verified
            </span>
          )}
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

      {/* Phone */}
      <div className="nl-field">
        <label htmlFor="phone">
          Phone number
        </label>

        <div className="nl-field-with-otp">
          <PhoneInput
            international
            defaultCountry="IN"
            countryCallingCodeEditable={false}
            value={form.phone}
            onChange={handlePhoneChange}
            className="nl-phone-input"
          />

          {phoneVerified && (
            <span className="nl-badge-verified">
              Verified
            </span>
          )}
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

      {/* Date of Birth */}
      <div className="nl-field">
        <label htmlFor="dob">
          Date of birth
        </label>

        <input
          id="dob"
          type="date"
          autoComplete="bday"
          value={form.dob}
          max={new Date().toISOString().split('T')[0]}
          onChange={update('dob')}
        />
      </div>

      {/* Age */}
      {dobEntered && !isInvalidDob && (
        <div
          className={`nl-age-readout${
            isUnderage ? ' is-blocked' : ''
          }`}
        >
          <span>Age on file</span>

          <strong>
            {age} {age === 1 ? 'year' : 'years'}
            {isUnderage
              ? ' — under minimum age'
              : ''}
          </strong>
        </div>
      )}

      {/* Invalid DOB */}
      {isInvalidDob && (
        <p className="nl-error">
          That date doesn&apos;t look right.
        </p>
      )}

      {/* Password */}
      <div className="nl-field">
        <label htmlFor="password">
          Password
        </label>

        <input
          id="password"
          type="password"
          autoComplete="new-password"
          value={form.password}
          onChange={update('password')}
        />
      </div>

      {/* Submit Error */}
      {touched && submitError && (
        <p className="nl-error">
          {submitError}
        </p>
      )}

      {/* Sign Up */}
      <button
        type="submit"
        className="nl-btn nl-btn-gold nl-btn-block"
        disabled={
          isUnderage ||
          !emailVerified ||
          !phoneVerified
        }
      >
        Sign Up
      </button>

      <p className="nl-note">
        Registration is limited to players aged{' '}
        {MINIMUM_AGE}+. Verify your email and phone above,
        then ID and passport verification happens after this
        step, through our KYC provider.
      </p>

    </form>
  );
}