$(document).on('ready page:load', function() {
    setTimeout(function() {
        $(".alert").fadeOut(function() {
            $(this).remove();
        })
    }, 3000 );
});
