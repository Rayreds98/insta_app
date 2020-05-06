$(document).on 'turbolinks:load', ->

  readURL = (input) ->
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        $('#avatar_img_prev').attr 'src', e.target.result
        return

      reader.readAsDataURL input.files[0]
    return

  $('#post_img').change ->
    $('#avatar_img_prev').removeClass 'hidden'
    $('.avatar_present_img').remove()
    readURL this
    return
  return
