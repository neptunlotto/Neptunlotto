import { useMemo } from 'react';

function firstName(user) {
  if (user?.fullName) return user.fullName.split(' ')[0];
  if (user?.email) return user.email.split('@')[0];
  return 'Player';
}

function nextDrawCountdown() {
  const now = new Date();
  const next = new Date(now);
  next.setHours(24, 0, 0, 0); // midnight tonight
  const diffMs = next - now;
  const hours = Math.floor(diffMs / 3_600_000);
  const minutes = Math.floor((diffMs % 3_600_000) / 60_000);
  return `${hours}h ${minutes}m`;
}

/**
 * Placeholder post-auth dashboard. There's no backend wired up yet —
 * this exists so sign-in/sign-up don't dead-end at a "redirecting…"
 * message. Swap the sample values below for real account, ticket,
 * and draw data once the API is available.
 */
export default function Dashboard({ user, onNavigate }) {
  const name = firstName(user);
  const countdown = useMemo(nextDrawCountdown, []);
  const isNewAccount = user?.mode === 'signup';

  return (
    <section className="nl-container nl-dashboard">
      <div className="nl-dashboard-head">
        <div>
          <span className="nl-eyebrow">Your account</span>
          <h1 className="nl-dashboard-title">Welcome back, {name}.</h1>
        </div>
        <button className="nl-btn nl-btn-gold" onClick={() => onNavigate('landing')}>
          Play Today&apos;s Draw
        </button>
      </div>

      {isNewAccount && (
        <div className="nl-dashboard-banner">
          <strong>Verification in review.</strong> We&apos;re confirming the
          ID documents you submitted with Sumsub — this usually takes just a
          few minutes, and we&apos;ll email {user.email} once it&apos;s approved.
        </div>
      )}

      <div className="nl-dashboard-grid">
        <div className="nl-dashboard-card">
          <span className="nl-eyebrow">Next draw</span>
          <p className="nl-dashboard-big">{countdown}</p>
          <p className="nl-dashboard-sub">Seven winners &middot; drawn nightly at midnight</p>
        </div>

        <div className="nl-dashboard-card">
          <span className="nl-eyebrow">Account status</span>
          <p className="nl-dashboard-big">{isNewAccount ? 'Pending' : 'Active'}</p>
          <p className="nl-dashboard-sub">
            {isNewAccount ? 'Email confirmation required' : 'Verified &amp; in good standing'}
          </p>
        </div>

        <div className="nl-dashboard-card">
          <span className="nl-eyebrow">Tickets this month</span>
          <p className="nl-dashboard-big">0</p>
          <p className="nl-dashboard-sub">$10 per entry</p>
        </div>
      </div>

      <div className="nl-dashboard-panel">
        <div className="nl-section-head" style={{ marginBottom: 'var(--space-3)' }}>
          <h2 className="nl-section-title">Your tickets</h2>
        </div>
        <div className="nl-dashboard-empty">
          <p>You haven&apos;t entered a draw yet.</p>
          <button className="nl-btn nl-btn-ghost" onClick={() => onNavigate('landing')}>
            Browse today&apos;s draw
          </button>
        </div>
      </div>

      <p className="nl-note">
        This dashboard is a placeholder — connect it to your real account,
        ticket, and draw-history endpoints to go live.
      </p>
    </section>
  );
}
