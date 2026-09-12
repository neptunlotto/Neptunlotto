import { useState } from 'react';
import { loginUser } from '../services/api';

export default function SignInForm({ onSuccess, onForgotPassword }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();

    if (!email || !password) {
      setError('Enter your email and password.');
      return;
    }

    setError('');
    setSubmitting(true);

    try {
      const data = await loginUser(email, password);

      localStorage.setItem('neptun_token', data.token);

      onSuccess?.({
        email: data.user.email,
        fullName: data.user.name,
      });
    } catch (err) {
      setError(err.message || 'Invalid email or password.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} noValidate>
      <div className="nl-field">
        <label htmlFor="signin-email">Email address</label>

        <input
          id="signin-email"
          type="email"
          autoComplete="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
      </div>

      <div className="nl-field">
        <label htmlFor="signin-password">Password</label>

        <input
          id="signin-password"
          type="password"
          autoComplete="current-password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>

      {error && <p className="nl-error">{error}</p>}

      <button
        type="submit"
        className="nl-btn nl-btn-gold nl-btn-block"
        disabled={submitting}
      >
        {submitting ? 'Signing in…' : 'Sign in'}
      </button>

      <button
        type="button"
        className="nl-link"
        onClick={onForgotPassword}
        style={{ marginTop: '12px' }}
      >
        Forgot Password?
      </button>

      <p className="nl-note">
        Multi-factor authentication may be requested on new devices.
      </p>
    </form>
  );
}