import { useRef, useState } from 'react';

import {
  verifyEmailOtp,
  resendEmailOtp,
  sendMobileOtp,
  verifyMobileOtp,
  resendMobileOtp,
} from '../services/api';

const CODE_LENGTH = 6;

export default function InlineOtpVerify({
  contact,
  disabled,
  label,
  onVerified,
}) {
  const [sent, setSent] = useState(false);
  const [sending, setSending] = useState(false);
  const [digits, setDigits] = useState(
    Array(CODE_LENGTH).fill('')
  );
  const [error, setError] = useState('');
  const [verifying, setVerifying] = useState(false);
  const [resent, setResent] = useState(false);

  const inputsRef = useRef([]);

  const isEmail = label === 'email';

  // SEND OTP
  async function handleSend() {
    if (disabled || sending) return;

    setError('');
    setSending(true);

    try {
      if (isEmail) {
        // Your signup backend already sends the email OTP.
        // So here we request a fresh OTP.
        await resendEmailOtp(contact);
      } else {
        // Twilio sends the SMS OTP.
        await sendMobileOtp(contact);
      }

      setSent(true);
      setDigits(Array(CODE_LENGTH).fill(''));
    } catch (err) {
      setError(
        err.message || 'Failed to send OTP. Please try again.'
      );
    } finally {
      setSending(false);
    }
  }

  // CHANGE ONE DIGIT
  function handleChange(i, raw) {
    const value = raw.replace(/\D/g, '').slice(-1);

    setDigits((prev) => {
      const next = [...prev];
      next[i] = value;
      return next;
    });

    if (value && i < CODE_LENGTH - 1) {
      inputsRef.current[i + 1]?.focus();
    }
  }

  // BACKSPACE
  function handleKeyDown(i, e) {
    if (
      e.key === 'Backspace' &&
      !digits[i] &&
      i > 0
    ) {
      inputsRef.current[i - 1]?.focus();
    }
  }

  // PASTE OTP
  function handlePaste(e) {
    const pasted = e.clipboardData
      .getData('text')
      .replace(/\D/g, '')
      .slice(0, CODE_LENGTH);

    if (!pasted) return;

    e.preventDefault();

    setDigits((prev) => {
      const next = [...prev];

      pasted.split('').forEach((digit, i) => {
        next[i] = digit;
      });

      return next;
    });

    inputsRef.current[
      Math.min(pasted.length, CODE_LENGTH - 1)
    ]?.focus();
  }

  // VERIFY OTP
  async function handleVerify() {
    const code = digits.join('');

    if (code.length !== CODE_LENGTH) {
      setError('Enter all 6 digits.');
      return;
    }

    setError('');
    setVerifying(true);

    try {
      if (isEmail) {
        // Backend checks the actual Gmail OTP.
        await verifyEmailOtp(contact, code);
      } else {
        // Twilio/backend checks the actual SMS OTP.
        await verifyMobileOtp(contact, code);
      }

      // IMPORTANT:
      // Only mark as verified after backend verification succeeds.
      onVerified?.();
    } catch (err) {
      // Wrong/expired OTP stays unverified.
      setError(
        err.message || 'Invalid OTP. Please try again.'
      );
    } finally {
      setVerifying(false);
    }
  }

  // RESEND OTP
  async function handleResend() {
    setError('');
    setResent(false);

    try {
      if (isEmail) {
        await resendEmailOtp(contact);
      } else {
        await resendMobileOtp(contact);
      }

      setDigits(Array(CODE_LENGTH).fill(''));
      setResent(true);

      setTimeout(() => {
        setResent(false);
      }, 4000);
    } catch (err) {
      setError(
        err.message || 'Failed to resend OTP. Please try again.'
      );
    }
  }

  // BEFORE OTP IS SENT
  if (!sent) {
    return (
      <button
        type="button"
        className="nl-otp-inline-send"
        onClick={handleSend}
        disabled={disabled || sending}
      >
        {sending ? 'Sending…' : 'Send OTP'}
      </button>
    );
  }

  // OTP INPUT
  return (
    <div className="nl-otp-inline">
      <div
        className="nl-otp-inline-digits"
        onPaste={handlePaste}
      >
        {digits.map((digit, i) => (
          <input
            key={i}
            ref={(el) => {
              inputsRef.current[i] = el;
            }}
            className="nl-otp-inline-input"
            inputMode="numeric"
            autoComplete="one-time-code"
            maxLength={1}
            value={digit}
            onChange={(e) =>
              handleChange(i, e.target.value)
            }
            onKeyDown={(e) =>
              handleKeyDown(i, e)
            }
            aria-label={`Digit ${i + 1} of ${label} verification code`}
          />
        ))}

        <button
          type="button"
          className="nl-otp-inline-verify"
          onClick={handleVerify}
          disabled={verifying}
        >
          {verifying ? 'Verifying…' : 'Verify'}
        </button>
      </div>

      {error && (
        <p className="nl-error">
          {error}
        </p>
      )}

      <p className="nl-otp-inline-note">
        Code sent to <strong>{contact}</strong>.{' '}

        <button
          type="button"
          className="nl-link"
          onClick={handleResend}
        >
          {resent ? 'Code resent' : 'Resend'}
        </button>
      </p>
    </div>
  );
}