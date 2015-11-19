$(document).on('keyup', '[data-behavior~=search-products]', function() {

	var query = $(this).val();

	if (query.length >= 3 || query.length === 0) {
		$.ajax({
			url: '/',
			type: 'GET',
			dataType: 'script',
			data: {q: query}
		});
	}
});
