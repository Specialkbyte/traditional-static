$ ->
  $(document).foundation()

  addUrlParam = (search, key, val) ->
    newParam = key + '=' + val
    params = '?' + newParam
    # Try to replace an existance instance
    params = search.replace(new RegExp('[?&]' + key + '[^&]*'), '&' + newParam)
    # If nothing was replaced, then add the new param to the end
    if params == search
      params += '&' + newParam

    params

  removeURLParam = (url, param) ->
    urlparts = url.split('?')
    if urlparts.length >= 2
      prefix = encodeURIComponent(param) + '='
      pars = urlparts[1].split(/[&;]/g)
      i = pars.length
      while i-- > 0
        if pars[i].indexOf(prefix, 0) == 0
          pars.splice i, 1
      if pars.length > 0
        urlparts[0] + '?' + pars.join('&')
      else
        urlparts[0]
    else
      url

  $('#university').change ->
    value = $(this).val()
    console.log value
    if value == "ALL"
      window.location = removeURLParam(window.location.href, 'university')
    else
      newUrl = document.location.pathname + addUrlParam document.location.search, 'university', value
      window.location = newUrl

  $('#order-by').change ->
    value = $(this).val()
    window.location = document.location.pathname + addUrlParam document.location.search, 'orderBy', value