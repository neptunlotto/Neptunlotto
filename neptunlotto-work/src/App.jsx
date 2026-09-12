import { useState } from 'react';
import './styles.css';
import NavBar from './components/NavBar';
import Hero from './components/Hero';
import HowItWorks from './components/HowItWorks';
import DailyWinners from './components/DailyWinners';
import MonthlyWinners from './components/MonthlyWinners';
import AuthCard from './components/AuthCard';
import KycVerification from './components/KycVerification';
import Dashboard from './components/Dashboard';
import Footer from './components/Footer';


export default function App() {
  const [view, setView] = useState('landing'); // 'landing' | 'signin' | 'signup' | 'kyc' | 'dashboard'
  const [user, setUser] = useState(null);

  function handleAuthSuccess(result) {
    // Existing account signing back in — already verified previously.
    setUser(result);
    setView('dashboard');
  }

  function handleSignupVerified(pendingUser) {
    // New account, OTP just confirmed — identity verification is next.
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

  return (
    <div>
      <NavBar onNavigate={setView} user={user} onSignOut={handleSignOut} />

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
        <KycVerification user={user} onComplete={handleKycComplete} onNavigate={setView} />
      )}

      {view === 'dashboard' && user && <Dashboard user={user} onNavigate={setView} />}

      <Footer />
    </div>
  );
  {step === "kyc" && (
  <KycVerification
    onComplete={() => setStep("dashboard")}
  />
)}
}
