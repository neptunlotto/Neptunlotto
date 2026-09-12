import { useState } from "react";

import {
  sendMobileOtp,
  verifyMobileOtp,
  resendMobileOtp,
} from "../services/api";


export default function MobileOtpVerification({
  mobile,
  onVerified,
}) {

  const [otp, setOtp] = useState("");
  const [message, setMessage] = useState("");
  const [otpSent, setOtpSent] =
    useState(false);

  const [loading, setLoading] =
    useState(false);


  async function handleSendOtp() {

    setLoading(true);

    try {

      const data =
        await sendMobileOtp(mobile);

      setMessage(data.message);

      setOtpSent(true);

    } catch (error) {

      setMessage(error.message);

    } finally {

      setLoading(false);

    }

  }


  async function handleVerify(e) {

    e.preventDefault();

    setLoading(true);

    try {

      const data =
        await verifyMobileOtp(
          mobile,
          otp
        );

      setMessage(data.message);

      if (
        data.status ===
        "approved"
      ) {

        setTimeout(() => {
          onVerified();
        }, 1000);

      }

    } catch (error) {

      setMessage(error.message);

    } finally {

      setLoading(false);

    }

  }


  async function handleResend() {

    try {

      const data =
        await resendMobileOtp(mobile);

      setMessage(data.message);

    } catch (error) {

      setMessage(error.message);

    }

  }


  return (

    <div className="verification-container">

      <h2>Verify Your Mobile</h2>

      <p>
        Verify your mobile number:
      </p>

      <strong>{mobile}</strong>


      {!otpSent ? (

        <button
          className="primary-btn"
          onClick={handleSendOtp}
          disabled={loading}
        >

          {loading
            ? "Sending..."
            : "Send OTP"}

        </button>

      ) : (

        <form onSubmit={handleVerify}>

          <input
            type="text"
            inputMode="numeric"
            maxLength="6"
            placeholder="Enter SMS OTP"
            value={otp}
            onChange={(e) =>
              setOtp(
                e.target.value.replace(
                  /\D/g,
                  ""
                )
              )
            }
          />


          <button
            className="primary-btn"
            disabled={loading}
          >

            {loading
              ? "Verifying..."
              : "Verify Mobile"}

          </button>


          <button
            type="button"
            className="text-btn"
            onClick={handleResend}
          >

            Resend OTP

          </button>

        </form>

      )}


      {message && (

        <p className="form-message">
          {message}
        </p>

      )}

    </div>

  );

}