$ ->
  $(document).foundation()

  addUrlParam = (search, key, val) ->
    newParam = key + '=' + val
    params = '?' + newParam
    # If the "search" string exists, then build params from it
    if search
      # Try to replace an existance instance
      params = search.replace(new RegExp('([\?&])' + key + '[^&]*'), '$1' + newParam)
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
    if value == "ALL"
      url = removeURLParam window.location.href, 'university'
      window.location = removeURLParam url, 'page' # reset pagination when changing filters
    else
      newUrl = document.location.pathname + addUrlParam document.location.search, 'university', value
      newUrl = removeURLParam newUrl, 'page' # reset pagination
      window.location = newUrl

  $('#order-by').change ->
    value = $(this).val()
    newUrl = document.location.pathname + addUrlParam document.location.search, 'orderBy', value
    window.location = removeURLParam newUrl, 'page' # reset pagination