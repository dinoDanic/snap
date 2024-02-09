function removeContentInsideCssValue(str: string): string {
  const regex = /:"[^"]*"/g;
  return str.replace(regex, "");
}


function removeContentActions(str: string): string {
  const regex = /:!+/g;
  return str.replace(regex, "");
}

export const prepareContent = (value: string): string => {
  const removeCssContent = removeContentInsideCssValue(value)
  const removeContentAvtions = removeContentActions(removeCssContent)
  return removeContentAvtions
}

export const calculateImportanceLevel = (str: string): number => {
  const match = str.match(/:(!+)/);
  return match ? match[1].length : 0;
};
