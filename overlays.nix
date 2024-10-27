{inputs, ...}: {
  zen-browser = final: _prev: {
    zen-browser = {
      specific = inputs.zen-browser.packages."${final.system}".specific;
      generic = inputs.zen-browser.packages."${final.system}".generic;
    };
  };
}
