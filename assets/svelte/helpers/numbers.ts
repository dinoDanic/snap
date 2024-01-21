const numberRegex = /^\d+$/;

export const isStringANumber = (value: string): boolean => {
  if (numberRegex.test(value)) {
    return true;
  } else return false;
};
