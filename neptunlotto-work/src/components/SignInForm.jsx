import { useState } from 'react';

export default function SignInForm({ onSuccess }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  function handleSubmit(e) {
    e.preventDefault();
    if (!email || !password) {
      setError('Enter your email and password.');
      return;
    }
    setError('');
    // Wire this up to the real authentication endpoint.
    onSuccess?.({ email });
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

      <button type="submit" className="nl-btn nl-btn-gold nl-btn-block">
        Sign in
      </button>

      <p className="nl-note">
        Multi-factor authentication may be requested on new devices.
      </p>
    </form>
  );
}
