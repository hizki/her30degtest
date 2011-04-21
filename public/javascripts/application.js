function changeMenuTab(currentTab) {
	$('.menu-tab').removeClass('current_page_item');
	$('#'+currentTab).addClass('current_page_item');
}
