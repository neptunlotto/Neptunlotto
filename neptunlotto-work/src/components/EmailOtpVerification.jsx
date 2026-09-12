import { useState } from "react";

import {
  verifyEmailOtp,
  resendEmailOtp,
} from "../services/api";

export default function EmailOtpVerification({
  email,
  onVerified,
}) {

  const [otp, setOtp] = useState("");
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleVerify(e) {
    e.preventDefault();

    if (otp.length !== 6) {
      setMessage("Please enter a valid 6-digit OTP");
      return;
    }

    setLoading(true);

    try {

      const data =
        await verifyEmailOtp(
          email,
          otp
        );

      setMessage(data.message);

      setTimeout(() => {
        onVerified();
      }, 1000);

    } catch (error) {

      setMessage(error.message);

    } finally {

      setLoading(false);

    }
  }


  async function handleResend() {

    try {

      const data =
        await resendEmailOtp(email);

      setMessage(data.message);

    } catch (error) {

      setMessage(error.message);

    }

  }


  return (

    <div className="verification-container">

      <h2>Verify Your Email</h2>

      <p>
        We sent a 6-digit OTP to:
      </p>

      <strong>{email}</strong>


      <form onSubmit={handleVerify}>

        <input
          type="text"
          inputMode="numeric"
          maxLength="6"
          placeholder="Enter 6-digit OTP"
          value={otp}
          onChange={(e) =>
            setOtp(
              e.target.value.replace(/\D/g, "")
            )
          }
        />


        <button
          type="submit"
          className="primary-btn"
          disabled={loading}
        >

          {loading
            ? "Verifying..."
            : "Verify Email"}

        </button>

      </form>


      <button
        className="text-btn"
        onClick={handleResend}
      >

        Resend OTP

      </button>


      {message && (

        <p className="form-message">
          {message}
        </p>

      )}

    </div>

  );

}