import { useMemo, useState, useEffect } from 'react';

const DIGIT_COUNT = 11;

function randomDigits() {
  return Array.from({ length: DIGIT_COUNT }, () => Math.floor(Math.random() * 10));
}

/**
 * Visualizes the "unique eleven-digit draw number, each digit
 * randomized 0-9" mechanic described in the proposal. Purely
 * decorative — no real draw logic lives on the frontend.
 */
export default function TicketReveal() {
  const initial = useMemo(randomDigits, []);
  const [digits, setDigits] = useState(initial);
  const [key, setKey] = useState(0);

  useEffect(() => {
    const id = setInterval(() => {
      setDigits(randomDigits());
      setKey((k) => k + 1);
    }, 4000);
    return () => clearInterval(id);
  }, []);

  return (
    <div className="nl-ticket" role="group" aria-label="Sample draw number preview">
      <div className="nl-ticket-label">
        <span className="k">Today&apos;s draw number</span>
        <span className="v">7 winners &middot; every 24h</span>
      </div>
      <div className="nl-digits" key={key}>
        {digits.map((d, i) => (
          <div className="nl-digit" key={i}>
            <span>{d}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
