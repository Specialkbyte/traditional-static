$ ->
  $(document).foundation()
  
  $('.video-slick', @$el).slick
    centerMode: true
    variableWidth: true
    infinite: true
    dots: true
    slidesToShow: 4
    slidesToScroll: 1
    responsive: [
      {
        breakpoint: 1024
        settings:
          slidesToShow: 3
          slidesToScroll: 1
          dots: true
      },
      {
        breakpoint: 640
        settings: 'unslick'
      }
    ]