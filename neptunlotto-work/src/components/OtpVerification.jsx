import { useRef, useState } from 'react';

const CODE_LENGTH = 6;

/**
 * Email/phone OTP entry shown right after sign-up, before the user
 * moves on to identity verification (KYC). Wire handleSubmit and
 * handleResend up to your real OTP endpoints — any 6-digit code is
 * accepted here since there's no backend yet.
 */
export default function OtpVerification({ contact, onVerify }) {
  const [digits, setDigits] = useState(Array(CODE_LENGTH).fill(''));
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [resent, setResent] = useState(false);
  const inputsRef = useRef([]);

  function setDigitAt(i, value) {
    setDigits((prev) => {
      const next = [...prev];
      next[i] = value;
      return next;
    });
  }

  function handleChange(i, raw) {
    const value = raw.replace(/\D/g, '').slice(-1);
    setDigitAt(i, value);
    if (value && i < CODE_LENGTH - 1) {
      inputsRef.current[i + 1]?.focus();
    }
  }

  function handleKeyDown(i, e) {
    if (e.key === 'Backspace' && !digits[i] && i > 0) {
      inputsRef.current[i - 1]?.focus();
    }
  }

  function handlePaste(e) {
    const pasted = e.clipboardData.getData('text').replace(/\D/g, '').slice(0, CODE_LENGTH);
    if (!pasted) return;
    e.preventDefault();
    setDigits((prev) => {
      const next = [...prev];
      pasted.split('').forEach((d, i) => {
        next[i] = d;
      });
      return next;
    });
    inputsRef.current[Math.min(pasted.length, CODE_LENGTH - 1)]?.focus();
  }

  function handleSubmit(e) {
    e.preventDefault();
    const code = digits.join('');
    if (code.length !== CODE_LENGTH) {
      setError('Enter all 6 digits from the code we sent you.');
      return;
    }
    setError('');
    setSubmitting(true);
    // TODO: replace with a real call to your OTP verification endpoint,
    // e.g. POST /api/auth/verify-otp { contact, code }.
    setTimeout(() => {
      setSubmitting(false);
      onVerify(code);
    }, 500);
  }

  function handleResend() {
    // TODO: trigger a real resend via your backend,
    // e.g. POST /api/auth/resend-otp { contact }.
    setResent(true);
    setTimeout(() => setResent(false), 4000);
  }

  return (
    <div className="nl-auth-card">
      <span className="nl-eyebrow">Verify your email</span>
      <h2 className="nl-otp-title">Enter the code we sent</h2>
      <p className="nl-otp-sub">
        We sent a 6-digit verification code to <strong>{contact}</strong>.
      </p>

      <form onSubmit={handleSubmit}>
        <div className="nl-otp-digits" onPaste={handlePaste}>
          {digits.map((d, i) => (
            <input
              key={i}
              ref={(el) => {
                inputsRef.current[i] = el;
              }}
              className="nl-otp-input"
              inputMode="numeric"
              autoComplete="one-time-code"
              maxLength={1}
              value={d}
              onChange={(e) => handleChange(i, e.target.value)}
              onKeyDown={(e) => handleKeyDown(i, e)}
              aria-label={`Digit ${i + 1} of verification code`}
            />
          ))}
        </div>

        {error && <p className="nl-error">{error}</p>}

        <button type="submit" className="nl-btn nl-btn-gold nl-btn-block" disabled={submitting}>
          {submitting ? 'Verifying…' : 'Verify & continue'}
        </button>
      </form>

      <p className="nl-note">
        Didn&apos;t get a code?{' '}
        <button type="button" className="nl-link" onClick={handleResend}>
          {resent ? 'Code resent' : 'Resend code'}
        </button>
      </p>
    </div>
  );
}
