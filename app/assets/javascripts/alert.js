$(document).on('ready page:load', function() {
    setTimeout(function() {
        $(".alert").fadeOut("slow", function() {
            $(this).remove();
        })
    }, 3000 );
});
