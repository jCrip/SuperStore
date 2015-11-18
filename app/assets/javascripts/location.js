$(document).on('page:change', function() {


	function geoSuccess(position) {
		var lat = position.coords.latitude;
		var lon = position.coords.longitude;

		$('.js-latitude').val(lat);
		$('.js-longitude').val(lon);

		$.ajax({
			url: '/get_address',
			type: 'GET',
			dataType: 'script',
			data: {
				latitude: lat,
				longitude: lon
			}
		});

	}

	function geoError(error) {
		alert('Try again later mother fucker!');
	}

	function getLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(geoSuccess, geoError);
		} else {
			alert('Geolocation is not supported by this browser, use Chrome, Firefox or Safari, never again use IE, stupid!!!');
		}
	}

	function getUserLocation() {
		$.ajax({
			url: '/get_address',
			type: 'GET',
			dataType: 'script',
		})
	}

	$('.js-getlocation').on('click', function(event) {
		event.preventDefault();
		getLocation();
	});

	if ($('.registrations.new').length > 0) {
		getLocation();
	}

	if ($('.registrations.edit').length > 0 ) {
		getUserLocation();
	}

});
