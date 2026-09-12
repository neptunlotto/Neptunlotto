import TicketReveal from './TicketReveal';

export default function Hero({ onNavigate }) {
  return (
    <section className="nl-container nl-hero">
      <span className="nl-eyebrow">Dream &middot; Play &middot; Win</span>
      <h1 className="nl-headline">
        A digital lottery, <em>run in the open.</em>
      </h1>
      <p className="nl-subhead">
        Register, verify your age once, and join a daily draw with seven
        winners — every number generated, logged, and auditable.
      </p>
      <div className="nl-hero-actions">
        <button className="nl-btn nl-btn-gold" onClick={() => onNavigate('signup')}>
          Play Today&apos;s Draw
        </button>
        <button className="nl-btn nl-btn-ghost" onClick={() => onNavigate('signin')}>
          I already have an account
        </button>
      </div>
      <TicketReveal />
    </section>
  );
}
