import { useState } from 'react';
import { resetPassword } from '../services/api';

export default function ResetPasswordForm({ token, email, onDone }) {
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [done, setDone] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();

    if (!newPassword || !confirmPassword) {
      setError('Fill in both password fields.');
      return;
    }

    if (newPassword.length < 8) {
      setError('Password must be at least 8 characters.');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('Passwords do not match.');
      return;
    }

    setError('');
    setSubmitting(true);

    try {
      await resetPassword(token, email, newPassword);
      setDone(true);
    } catch (err) {
      setError(
        err.message || 'Something went wrong. Please try again.'
      );
    } finally {
      setSubmitting(false);
    }
  }

  if (!token || !email) {
    return (
      <div className="nl-auth-wrap nl-container">
        <div className="nl-auth-card">
          <h3>Invalid reset link</h3>

          <p className="nl-note">
            This link is missing information and can&apos;t be used.
            Please request a new password reset link.
          </p>

          <button
            type="button"
            className="nl-btn nl-btn-gold nl-btn-block"
            onClick={onDone}
          >
            Back to sign in
          </button>
        </div>
      </div>
    );
  }

  if (done) {
    return (
      <div className="nl-auth-wrap nl-container">
        <div className="nl-auth-card nl-success">
          <h3>Password reset</h3>

          <p>
            You can now sign in with your new password.
          </p>

          <button
            type="button"
            className="nl-btn nl-btn-gold nl-btn-block"
            onClick={onDone}
          >
            Go to sign in
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="nl-auth-wrap nl-container">
      <div className="nl-auth-card">
        <form onSubmit={handleSubmit} noValidate>

          <h3>Choose a new password</h3>

          <p className="nl-note">
            Resetting the password for {email}.
          </p>

          <div className="nl-field">
            <label htmlFor="new-password">
              New password
            </label>

            <input
              id="new-password"
              type="password"
              autoComplete="new-password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
            />
          </div>

          <div className="nl-field">
            <label htmlFor="confirm-password">
              Confirm new password
            </label>

            <input
              id="confirm-password"
              type="password"
              autoComplete="new-password"
              value={confirmPassword}
              onChange={(e) =>
                setConfirmPassword(e.target.value)
              }
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
            {submitting ? 'Resetting…' : 'Reset password'}
          </button>

        </form>
      </div>
    </div>
  );
}