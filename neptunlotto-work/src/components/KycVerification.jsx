import { useState } from "react";

export default function KycVerification({ onComplete }) {
  const [step, setStep] = useState(1);

  const [formData, setFormData] = useState({
    fullName: "",
    dateOfBirth: "",
    nationality: "",
    address: "",
    city: "",
    country: "",
    postalCode: "",
    documentType: "",
  });

  const [documentFile, setDocumentFile] = useState(null);
  const [selfieFile, setSelfieFile] = useState(null);

  function handleChange(e) {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  }

  function nextStep() {
    setStep((current) => current + 1);
  }

  function previousStep() {
    setStep((current) => current - 1);
  }

  function handleSubmit() {
    // Frontend-only KYC simulation
    localStorage.setItem(
      "neptun_kyc",
      JSON.stringify({
        ...formData,
        documentName: documentFile?.name || "",
        selfieName: selfieFile?.name || "",
        status: "pending",
      })
    );

    setStep(4);
  }

  return (
    <div className="kyc-page">
      <div className="kyc-card">

        <div className="kyc-header">
          <div className="kyc-shield">🛡</div>

          <h2>Identity Verification</h2>

          <p>
            Complete your KYC verification to access all NEPTUN LOTTO features.
          </p>
        </div>

        <div className="kyc-progress">
          <div className={`progress-item ${step >= 1 ? "active" : ""}`}>
            <span>1</span>
            <small>Personal Info</small>
          </div>

          <div className="progress-line"></div>

          <div className={`progress-item ${step >= 2 ? "active" : ""}`}>
            <span>2</span>
            <small>Document</small>
          </div>

          <div className="progress-line"></div>

          <div className={`progress-item ${step >= 3 ? "active" : ""}`}>
            <span>3</span>
            <small>Selfie</small>
          </div>
        </div>

        {/* STEP 1 - PERSONAL INFORMATION */}

        {step === 1 && (
          <div className="kyc-step">

            <h3>Personal Information</h3>

            <div className="kyc-form-grid">

              <div className="form-group">
                <label>Full Name</label>

                <input
                  type="text"
                  name="fullName"
                  placeholder="Enter your full name"
                  value={formData.fullName}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label>Date of Birth</label>

                <input
                  type="date"
                  name="dateOfBirth"
                  value={formData.dateOfBirth}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label>Nationality</label>

                <input
                  type="text"
                  name="nationality"
                  placeholder="Enter your nationality"
                  value={formData.nationality}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label>Document Type</label>

                <select
                  name="documentType"
                  value={formData.documentType}
                  onChange={handleChange}
                >
                  <option value="">Select document</option>
                  <option value="passport">Passport</option>
                  <option value="driving-license">
                    Driving License
                  </option>
                  <option value="national-id">
                    National ID Card
                  </option>
                </select>
              </div>

            </div>

            <div className="form-group">
              <label>Address</label>

              <input
                type="text"
                name="address"
                placeholder="Enter your address"
                value={formData.address}
                onChange={handleChange}
              />
            </div>

            <div className="kyc-form-grid">

              <div className="form-group">
                <label>City</label>

                <input
                  type="text"
                  name="city"
                  placeholder="Enter your city"
                  value={formData.city}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label>Country</label>

                <input
                  type="text"
                  name="country"
                  placeholder="Enter your country"
                  value={formData.country}
                  onChange={handleChange}
                />
              </div>

              <div className="form-group">
                <label>Postal Code</label>

                <input
                  type="text"
                  name="postalCode"
                  placeholder="Postal code"
                  value={formData.postalCode}
                  onChange={handleChange}
                />
              </div>

            </div>

            <button
              className="primary-btn"
              onClick={nextStep}
              disabled={!formData.fullName || !formData.dateOfBirth}
            >
              Continue
            </button>

          </div>
        )}

        {/* STEP 2 - DOCUMENT */}

        {step === 2 && (
          <div className="kyc-step">

            <h3>Upload Identity Document</h3>

            <p className="kyc-description">
              Upload a clear photo of your selected identity document.
            </p>

            <div className="upload-box">

              <div className="upload-icon">📄</div>

              <h4>
                {documentFile
                  ? documentFile.name
                  : "Upload Identity Document"}
              </h4>

              <p>
                PNG, JPG or PDF files are supported
              </p>

              <input
                type="file"
                id="document-upload"
                accept=".png,.jpg,.jpeg,.pdf"
                hidden
                onChange={(e) =>
                  setDocumentFile(e.target.files[0])
                }
              />

              <label
                htmlFor="document-upload"
                className="upload-btn"
              >
                Choose File
              </label>

            </div>

            <div className="kyc-buttons">

              <button
                className="secondary-btn"
                onClick={previousStep}
              >
                Back
              </button>

              <button
                className="primary-btn"
                onClick={nextStep}
                disabled={!documentFile}
              >
                Continue
              </button>

            </div>

          </div>
        )}

        {/* STEP 3 - SELFIE */}

        {step === 3 && (
          <div className="kyc-step">

            <h3>Selfie Verification</h3>

            <p className="kyc-description">
              Upload a clear selfie where your face is clearly visible.
            </p>

            <div className="upload-box">

              <div className="upload-icon">📷</div>

              <h4>
                {selfieFile
                  ? selfieFile.name
                  : "Upload Your Selfie"}
              </h4>

              <p>
                Make sure your face is clearly visible.
              </p>

              <input
                type="file"
                id="selfie-upload"
                accept="image/*"
                capture="user"
                hidden
                onChange={(e) =>
                  setSelfieFile(e.target.files[0])
                }
              />

              <label
                htmlFor="selfie-upload"
                className="upload-btn"
              >
                Upload Selfie
              </label>

            </div>

            <div className="kyc-buttons">

              <button
                className="secondary-btn"
                onClick={previousStep}
              >
                Back
              </button>

              <button
                className="primary-btn"
                onClick={handleSubmit}
                disabled={!selfieFile}
              >
                Submit Verification
              </button>

            </div>

          </div>
        )}

        {/* STEP 4 - SUCCESS */}

        {step === 4 && (
          <div className="kyc-success">

            <div className="success-icon">✓</div>

            <h2>KYC Submitted Successfully!</h2>

            <p>
              Your identity verification has been submitted successfully.
            </p>

            <p>
              Your verification status is currently:
            </p>

            <div className="kyc-status">
              Pending Verification
            </div>

            <button
              className="primary-btn"
              onClick={onComplete}
            >
              Continue to Dashboard
            </button>

          </div>
        )}

      </div>
    </div>
  );
}