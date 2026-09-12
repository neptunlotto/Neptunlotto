import { useState, useEffect } from 'react';
import SignInForm from './SignInForm';
import SignUpForm from './SignUpForm';

export default function AuthCard({ initialTab = 'signin', onAuthSuccess, onSignupVerified }) {
  const [tab, setTab] = useState(initialTab);
  const [result, setResult] = useState(null); // sign-in success state

  // AuthCard stays mounted while the user bounces between the "Sign In"
  // and "Create Account" nav buttons (App just flips the `view` prop),
  // so without this the tab never actually switches and clicking the
  // nav button appears to do nothing. Re-sync whenever the parent
  // tells us which tab it wants, and clear any leftover success screen.
  useEffect(() => {
    setTab(initialTab);
    setResult(null);
  }, [initialTab]);

  // Once we have a sign-in result, briefly show the confirmation card —
  // then hand off to the parent so it can route to the dashboard. This
  // is where a real app would instead wait on the auth API response.
  useEffect(() => {
    if (!result) return undefined;
    const id = setTimeout(() => {
      onAuthSuccess?.(result);
    }, 1200);
    return () => clearTimeout(id);
  }, [result, onAuthSuccess]);

  if (result) {
    return (
      <div className="nl-auth-wrap nl-container">
        <div className="nl-auth-card nl-success">
          <h3>Signed in</h3>
          <p>Redirecting you to your dashboard…</p>
        </div>
      </div>
    );
  }

  return (
    <div className="nl-auth-wrap nl-container">
      <div className="nl-auth-card">
        <div className="nl-tabs" role="tablist" aria-label="Sign in or create account">
          <button
            role="tab"
            aria-selected={tab === 'signin'}
            className="nl-tab"
            onClick={() => setTab('signin')}
          >
            Sign In
          </button>
          <button
            role="tab"
            aria-selected={tab === 'signup'}
            className="nl-tab"
            onClick={() => setTab('signup')}
          >
            Sign Up
          </button>
        </div>

        {tab === 'signin' ? (
          <SignInForm onSuccess={(data) => setResult({ mode: 'signin', ...data })} />
        ) : (
          // Email and phone are already verified inline on the form
          // itself (see SignUpForm's InlineOtpVerify usage), so a
          // successful submit here goes straight on to KYC.
          <SignUpForm onSuccess={(data) => onSignupVerified?.({ mode: 'signup', ...data })} />
        )}
      </div>
    </div>
  );
}