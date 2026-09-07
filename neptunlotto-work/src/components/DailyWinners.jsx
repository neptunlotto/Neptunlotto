import { useMemo } from 'react';

/**
 * Sample data for the seven daily winners. Wire this up to the real
 * draw-results endpoint — names should always be masked server-side
 * (or omitted entirely) before they reach the client, never masked
 * here after the fact.
 *
 * Daily draws pay out in cash. Physical prizes (car, motorbike,
 * phone, and smaller gifts) are reserved for the monthly draw —
 * see MonthlyWinners.jsx.
 */
const SAMPLE_WINNERS = [
  { rank: 1, name: 'A. Fernandez', city: 'Austin, TX', ticket: '58204471963', prize: 25000, tier: 'Grand Prize' },
  { rank: 2, name: 'M. Okafor', city: 'Newark, NJ', ticket: '10938275640', prize: 5000, tier: 'Second Prize' },
  { rank: 3, name: 'J. Lindqvist', city: 'Duluth, MN', ticket: '77261948503', prize: 1000, tier: 'Third Prize' },
  { rank: 4, name: 'R. Castillo', city: 'Fresno, CA', ticket: '39481027655', prize: 500, tier: 'Runner-up' },
  { rank: 5, name: 'S. Patel', city: 'Edison, NJ', ticket: '64207193384', prize: 500, tier: 'Runner-up' },
  { rank: 6, name: 'D. Kowalski', city: 'Erie, PA', ticket: '82056391470', prize: 250, tier: 'Runner-up' },
  { rank: 7, name: 'L. Nguyen', city: 'Garden Grove, CA', ticket: '15937048261', prize: 250, tier: 'Runner-up' },
];

function maskName(name) {
  // e.g. "A. Fernandez" -> "A. F*******"
  const parts = name.split(' ');
  const last = parts[parts.length - 1] ?? '';
  const masked = last.length > 1 ? last[0] + '*'.repeat(last.length - 1) : last;
  return [...parts.slice(0, -1), masked].join(' ');
}

function maskTicket(ticket) {
  // Show first 3 and last 2 digits only.
  return `${ticket.slice(0, 3)}${'•'.repeat(ticket.length - 5)}${ticket.slice(-2)}`;
}

function formatPrize(amount) {
  return amount.toLocaleString('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 });
}

function todayLabel() {
  return new Date().toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });
}

export default function DailyWinners({ winners = SAMPLE_WINNERS }) {
  const dateLabel = useMemo(todayLabel, []);

  return (
    <section className="nl-section nl-container" aria-labelledby="daily-winners">
      <div className="nl-section-head">
        <span className="nl-eyebrow">Verified &amp; published daily</span>
        <h2 className="nl-section-title" id="daily-winners">
          Today&apos;s seven winners
        </h2>
        <p className="nl-winners-date">{dateLabel}</p>
      </div>

      <div className="nl-winners-grid">
        {winners.map((w) => (
          <article
            className={`nl-winner-card${w.rank === 1 ? ' is-top' : ''}`}
            key={w.rank}
          >
            <div className="nl-winner-rank">
              <span>#{w.rank}</span>
              <span className="nl-winner-tier">{w.tier}</span>
            </div>

            <p className="nl-winner-name">{maskName(w.name)}</p>
            <p className="nl-winner-city">{w.city}</p>

            <div className="nl-winner-ticket">
              <span className="k">Draw number</span>
              <span className="v">{maskTicket(w.ticket)}</span>
            </div>

            <p className="nl-winner-prize">{formatPrize(w.prize)}</p>
          </article>
        ))}
      </div>

      <p className="nl-winners-note">
        Names and draw numbers are partially masked for privacy. Full results
        are available to verified account holders on the winners archive.
      </p>
    </section>
  );
}
