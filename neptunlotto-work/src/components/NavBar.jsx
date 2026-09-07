export default function NavBar({ onNavigate, user, onSignOut }) {
  return (
    <header className="nl-container nl-nav">
      <button
        className="nl-wordmark"
        onClick={() => onNavigate(user ? 'dashboard' : 'landing')}
      >
        Neptunlotto <span className="leaf" aria-hidden="true">✦</span>
      </button>
      <nav className="nl-nav-actions">
        {user ? (
          <>
            <button className="nl-btn nl-btn-ghost" onClick={() => onNavigate('dashboard')}>
              Dashboard
            </button>
            <button className="nl-btn nl-btn-gold" onClick={onSignOut}>
              Sign Out
            </button>
          </>
        ) : (
          <>
            <button className="nl-btn nl-btn-ghost" onClick={() => onNavigate('signin')}>
              Sign In
            </button>
            <button className="nl-btn nl-btn-gold" onClick={() => onNavigate('signup')}>
              Sign Up
            </button>
          </>
        )}
      </nav>
    </header>
  );
}
