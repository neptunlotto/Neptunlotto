import { useState } from 'react';
import './styles.css';

import NavBar from './components/NavBar';
import Hero from './components/Hero';
import HowItWorks from './components/HowItWorks';
import DailyWinners from './components/DailyWinners';
import MonthlyWinners from './components/MonthlyWinners';
import AuthCard from './components/AuthCard';
import ForgotPasswordForm from './components/ForgotPasswordForm';
import ResetPasswordForm from './components/ResetPasswordForm';
import KycVerification from './components/KycVerification';
import Dashboard from './components/Dashboard';
import Footer from './components/Footer';

export default function App() {
  const [view, setView] = useState('landing');
  const [user, setUser] = useState(null);

  function handleAuthSuccess(result) {
    // Existing account signing back in.
    setUser(result);
    setView('dashboard');
  }

  function handleSignupVerified(pendingUser) {
    // New account, OTP confirmed — KYC is next.
    setUser(pendingUser);
    setView('kyc');
  }

  function handleKycComplete() {
    setView('dashboard');
  }

  function handleSignOut() {
    setUser(null);
    setView('landing');
  }

  function handleResetDone() {
    // Remove the reset URL and return to Sign In.
    window.history.replaceState({}, '', '/');
    setView('signin');
  }

  // Check whether the user opened the password reset link.
  const isResetPasswordPage =
    window.location.pathname === '/reset-password';

  if (isResetPasswordPage) {
    const params = new URLSearchParams(window.location.search);

    const token = params.get('token');
    const email = params.get('email');

    return (
      <div>
        <NavBar
          onNavigate={setView}
          user={user}
          onSignOut={handleSignOut}
        />

        <ResetPasswordForm
          token={token}
          email={email}
          onDone={handleResetDone}
        />

        <Footer />
      </div>
    );
  }

  return (
    <div>
      <NavBar
        onNavigate={setView}
        user={user}
        onSignOut={handleSignOut}
      />

      {view === 'landing' && (
        <>
          <Hero onNavigate={setView} />
          <HowItWorks />
          <DailyWinners />
          <MonthlyWinners />
        </>
      )}

      {(view === 'signin' || view === 'signup') && (
        <AuthCard
          initialTab={view === 'signup' ? 'signup' : 'signin'}
          onAuthSuccess={handleAuthSuccess}
          onSignupVerified={handleSignupVerified}
        />
      )}

      {view === 'kyc' && user && (
        <KycVerification
          user={user}
          onComplete={handleKycComplete}
          onNavigate={setView}
        />
      )}

      {view === 'dashboard' && user && (
        <Dashboard
          user={user}
          onNavigate={setView}
        />
      )}

      <Footer />
    </div>
  );
}