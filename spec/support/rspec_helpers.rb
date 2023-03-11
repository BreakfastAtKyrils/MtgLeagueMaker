def select_option(css_selector, value)
  find(:css, css_selector).find(:option, value).select_option
end