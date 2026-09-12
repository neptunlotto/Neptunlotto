import { useState } from 'react';
import { forgotPassword } from '../services/api';

export default function ForgotPasswordForm({ onBack }) {
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [sent, setSent] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();

    if (!email) {
      setError('Enter your email address.');
      return;
    }

    setError('');
    setSubmitting(true);

    try {
      await forgotPassword(email);
      setSent(true);
    } catch (err) {
      setError(
        err.message || 'Something went wrong. Please try again.'
      );
    } finally {
      setSubmitting(false);
    }
  }

  if (sent) {
    return (
      <div>
        <h3>Check your email</h3>

        <p className="nl-note">
          We&apos;ve sent a password reset link to your email.
          Please check your inbox and click the Reset Password
          link. The link expires in 30 minutes.
        </p>

        <button
          type="button"
          className="nl-btn nl-btn-gold nl-btn-block"
          onClick={onBack}
        >
          Back to sign in
        </button>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} noValidate>
      <h3>Reset your password</h3>

      <p className="nl-note">
        Enter the email address on your account and we&apos;ll
        send you a link to reset your password.
      </p>

      <div className="nl-field">
        <label htmlFor="forgot-email">
          Email address
        </label>

        <input
          id="forgot-email"
          type="email"
          autoComplete="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
      </div>

      {error && (
        <p className="nl-error">
          {error}
        </p>
      )}

      <button
        type="submit"
        className="nl-btn nl-btn-gold nl-btn-block"
        disabled={submitting}
      >
        {submitting ? 'Sending…' : 'Send reset link'}
      </button>

      <button
        type="button"
        className="nl-link"
        onClick={onBack}
        style={{ marginTop: '12px' }}
      >
        Back to sign in
      </button>
    </form>
  );
}