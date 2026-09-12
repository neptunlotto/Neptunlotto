const STEPS = [
  {
    n: '01',
    title: 'Log in',
    body: 'Securely access your verified account from web or mobile.',
  },
  {
    n: '02',
    title: 'Purchase a ticket',
    body: 'Each play is $10, charged through a PCI-DSS-compliant gateway.',
  },
  {
    n: '03',
    title: 'The draw runs',
    body: 'A certified RNG generates a unique 11-digit number every 24 hours.',
  },
  {
    n: '04',
    title: 'Winners are notified',
    body: 'Seven winners are picked daily and notified by email and dashboard.',
  },
];

export default function HowItWorks() {
  return (
    <section className="nl-section nl-container" aria-labelledby="how-it-works">
      <div className="nl-section-head">
        <span className="nl-eyebrow">The mechanics</span>
        <h2 className="nl-section-title" id="how-it-works">
          How a draw actually happens
        </h2>
      </div>
      <div className="nl-steps">
        {STEPS.map((step) => (
          <div className="nl-step" key={step.n}>
            <span className="n">{step.n}</span>
            <h3>{step.title}</h3>
            <p>{step.body}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
