import { useMemo } from 'react';

/**
 * Sample data for the monthly gift-prize winners. Wire this up to the
 * real draw-results endpoint — names should always be masked
 * server-side (or omitted entirely) before they reach the client,
 * never masked here after the fact.
 *
 * Unlike the daily draw (paid out in cash — see DailyWinners.jsx),
 * the monthly draw is gifted with physical prizes: a car, motorbike,
 * phone, and smaller gifts.
 */
const SAMPLE_WINNERS = [
  { rank: 1, name: 'K. Whitfield', city: 'Denver, CO', ticket: '93172056648', tier: 'Grand Prize', gift: 'Sedan Car', icon: '🚗' },
  { rank: 2, name: 'B. Alavi', city: 'Plano, TX', ticket: '40865192237', tier: 'Second Prize', gift: 'Motorbike', icon: '🏍️' },
  { rank: 3, name: 'T. Marchetti', city: 'Providence, RI', ticket: '68204957310', tier: 'Third Prize', gift: 'Smartphone', icon: '📱' },
  { rank: 4, name: 'H. Delacroix', city: 'Baton Rouge, LA', ticket: '52930817465', tier: 'Runner-up', gift: 'Smart Watch', icon: '⌚' },
  { rank: 5, name: 'N. Osei', city: 'Columbus, OH', ticket: '17604829351', tier: 'Runner-up', gift: 'Wireless Earbuds', icon: '🎧' },
];

function maskName(name) {
  const parts = name.split(' ');
  const last = parts[parts.length - 1] ?? '';
  const masked = last.length > 1 ? last[0] + '*'.repeat(last.length - 1) : last;
  return [...parts.slice(0, -1), masked].join(' ');
}

function maskTicket(ticket) {
  return `${ticket.slice(0, 3)}${'•'.repeat(ticket.length - 5)}${ticket.slice(-2)}`;
}

function monthLabel() {
  return new Date().toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
}

export default function MonthlyWinners({ winners = SAMPLE_WINNERS }) {
  const monthTag = useMemo(monthLabel, []);

  return (
    <section className="nl-section nl-container" aria-labelledby="monthly-winners">
      <div className="nl-section-head">
        <span className="nl-eyebrow">Verified &amp; published monthly</span>
        <h2 className="nl-section-title" id="monthly-winners">
          This month&apos;s gift winners
        </h2>
        <p className="nl-winners-date">{monthTag}</p>
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

            <p className="nl-winner-prize nl-winner-gift">
              <span className="nl-gift-icon" aria-hidden="true">{w.icon}</span>
              {w.gift}
            </p>
          </article>
        ))}
      </div>

      <p className="nl-winners-note">
        Names and draw numbers are partially masked for privacy. Prize
        items are shipped or arranged for pickup with the winner&apos;s
        verified account within 5–7 business days.
      </p>
    </section>
  );
}
