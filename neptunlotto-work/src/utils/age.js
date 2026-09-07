/**
 * Calculates a person's age in whole years from a date-of-birth string.
 * Accepts any value the native Date constructor can parse (e.g. the
 * "YYYY-MM-DD" string an <input type="date"> gives you).
 *
 * Returns null if the input is empty or not a valid date, so callers
 * can distinguish "no answer yet" from "answer is 0".
 */
export function calculateAge(dobString) {
  if (!dobString) return null;

  const dob = new Date(dobString);
  if (Number.isNaN(dob.getTime())) return null;

  const today = new Date();
  if (dob > today) return null; // birthdate in the future isn't valid

  let age = today.getFullYear() - dob.getFullYear();
  const hasHadBirthdayThisYear =
    today.getMonth() > dob.getMonth() ||
    (today.getMonth() === dob.getMonth() && today.getDate() >= dob.getDate());

  if (!hasHadBirthdayThisYear) age -= 1;

  return age;
}

export const MINIMUM_AGE = 18;
