import { API_BASE_URL } from "../config";

async function request(endpoint, options = {}) {
  const response = await fetch(`${API_BASE_URL}${endpoint}`, {
    headers: {
      "Content-Type": "application/json",
      ...(options.headers || {}),
    },
    ...options,
  });

  const data = await response.json();

  if (!response.ok) {
    throw new Error(data.message || "Something went wrong");
  }

  return data;
}

// ==============================
// SIGN UP
// ==============================

export function signupUser(userData) {
  return request("/api/auth/signup", {
    method: "POST",
    body: JSON.stringify(userData),
  });
}

// ==============================
// VERIFY EMAIL OTP
// ==============================

export function verifyEmailOtp(email, otp) {
  return request("/api/auth/verify-otp", {
    method: "POST",
    body: JSON.stringify({
      email,
      otp,
    }),
  });
}

// ==============================
// RESEND EMAIL OTP
// ==============================

export function resendEmailOtp(email) {
  return request("/api/auth/resend-otp", {
    method: "POST",
    body: JSON.stringify({
      email,
    }),
  });
}

// ==============================
// SEND MOBILE OTP
// ==============================

export function sendMobileOtp(mobile) {
  return request("/api/auth/send-sms-otp", {
    method: "POST",
    body: JSON.stringify({
      mobile,
    }),
  });
}

// ==============================
// VERIFY MOBILE OTP
// ==============================

export function verifyMobileOtp(mobile, otp) {
  return request("/api/auth/verify-sms-otp", {
    method: "POST",
    body: JSON.stringify({
      mobile,
      otp,
    }),
  });
}

// ==============================
// RESEND MOBILE OTP
// ==============================

export function resendMobileOtp(mobile) {
  return request("/api/auth/resend-sms-otp", {
    method: "POST",
    body: JSON.stringify({
      mobile,
    }),
  });
}

// ==============================
// START KYC
// ==============================

export function startKyc(userId) {
  return request("/api/kyc/start", {
    method: "POST",
    body: JSON.stringify({
      userId,
    }),
  });
}

// LOGIN
export function loginUser(email, password) {
  return request("/api/auth/login", {
    method: "POST",
    body: JSON.stringify({
      email,
      password,
    }),
  });
}
// FORGOT PASSWORD
export function forgotPassword(email) {
  return request("/api/auth/forgot-password", {
    method: "POST",
    body: JSON.stringify({
      email,
    }),
  });
}
// RESET PASSWORD
export function resetPassword(token, email, newPassword) {
  return request("/api/auth/reset-password", {
    method: "POST",
    body: JSON.stringify({
      token,
      email,
      newPassword,
    }),
  });
}