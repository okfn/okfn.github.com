
// Add ... after text
$(document).ready(function() {
		$(".project-table td .text").dotdotdot({
				after: "a.read-more", // put after the ellipsis
				watch: true, // allow it to work with tabs
	});
});
