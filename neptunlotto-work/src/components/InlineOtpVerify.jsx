import { useRef, useState } from 'react';

const CODE_LENGTH = 6;

/**
 * Inline "Send OTP" → 6-digit code → verified widget, meant to sit
 * directly under a form field (email or phone). Wire handleSend,
 * handleVerify, and handleResend up to your real OTP endpoints — any
 * 6-digit code is accepted here since there's no backend yet.
 */
export default function InlineOtpVerify({ contact, disabled, label, onVerified }) {
  const [sent, setSent] = useState(false);
  const [sending, setSending] = useState(false);
  const [digits, setDigits] = useState(Array(CODE_LENGTH).fill(''));
  const [error, setError] = useState('');
  const [verifying, setVerifying] = useState(false);
  const [resent, setResent] = useState(false);
  const inputsRef = useRef([]);

  function handleSend() {
    if (disabled || sending) return;
    setSending(true);
    // TODO: call your real "send OTP" endpoint, e.g.
    // POST /api/auth/send-otp { channel: label, contact }
    setTimeout(() => {
      setSending(false);
      setSent(true);
    }, 500);
  }

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

  function handleVerify() {
    const code = digits.join('');
    if (code.length !== CODE_LENGTH) {
      setError('Enter all 6 digits.');
      return;
    }
    setError('');
    setVerifying(true);
    // TODO: call your real "verify OTP" endpoint, e.g.
    // POST /api/auth/verify-otp { channel: label, contact, code }
    setTimeout(() => {
      setVerifying(false);
      onVerified?.();
    }, 500);
  }

  function handleResend() {
    // TODO: trigger a real resend via your backend,
    // e.g. POST /api/auth/send-otp { channel: label, contact }.
    setResent(true);
    setTimeout(() => setResent(false), 4000);
  }

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

  return (
    <div className="nl-otp-inline">
      <div className="nl-otp-inline-digits" onPaste={handlePaste}>
        {digits.map((d, i) => (
          <input
            key={i}
            ref={(el) => {
              inputsRef.current[i] = el;
            }}
            className="nl-otp-inline-input"
            inputMode="numeric"
            autoComplete="one-time-code"
            maxLength={1}
            value={d}
            onChange={(e) => handleChange(i, e.target.value)}
            onKeyDown={(e) => handleKeyDown(i, e)}
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

      {error && <p className="nl-error">{error}</p>}

      <p className="nl-otp-inline-note">
        Code sent to <strong>{contact}</strong>.{' '}
        <button type="button" className="nl-link" onClick={handleResend}>
          {resent ? 'Code resent' : 'Resend'}
        </button>
      </p>
    </div>
  );
}