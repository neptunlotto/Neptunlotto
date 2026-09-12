import { useState, useEffect } from 'react';
import SignInForm from './SignInForm';
import SignUpForm from './SignUpForm';
import ForgotPasswordForm from './ForgotPasswordForm';

export default function AuthCard({
  initialTab = 'signin',
  onAuthSuccess,
  onSignupVerified
}) {
  const [tab, setTab] = useState(initialTab);
  const [result, setResult] = useState(null);

  // Keep the selected tab in sync with the parent.
  useEffect(() => {
    setTab(initialTab);
    setResult(null);
  }, [initialTab]);

  // After successful sign-in, show confirmation briefly.
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

        {/* Sign In / Sign Up tabs */}
        {tab !== 'forgot' && (
          <div
            className="nl-tabs"
            role="tablist"
            aria-label="Sign in or create account"
          >
            <button
              type="button"
              role="tab"
              aria-selected={tab === 'signin'}
              className="nl-tab"
              onClick={() => setTab('signin')}
            >
              Sign In
            </button>

            <button
              type="button"
              role="tab"
              aria-selected={tab === 'signup'}
              className="nl-tab"
              onClick={() => setTab('signup')}
            >
              Sign Up
            </button>
          </div>
        )}

        {/* Sign In */}
        {tab === 'signin' && (
          <SignInForm
            onSuccess={(data) =>
              setResult({
                mode: 'signin',
                ...data
              })
            }
            onForgotPassword={() => setTab('forgot')}
          />
        )}

        {/* Forgot Password */}
        {tab === 'forgot' && (
          <ForgotPasswordForm
            onBack={() => setTab('signin')}
          />
        )}

        {/* Sign Up */}
        {tab === 'signup' && (
          <SignUpForm
            onSuccess={(data) =>
              onSignupVerified?.({
                mode: 'signup',
                ...data
              })
            }
          />
        )}

      </div>
    </div>
  );
}