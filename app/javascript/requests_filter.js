document.addEventListener('DOMContentLoaded', () => {
  const affiliationFilter = document.getElementById('affiliation_filter');
  const articleFilter = document.getElementById('article_filter');
  const statusFilter = document.getElementById('status_filter');

  const requestLists = document.querySelectorAll('.request_input_lists');

  const filterRequests = () => {
    const selectedAffiliation = affiliationFilter.value;
    const selectedArticle = articleFilter.value;
    const selectedStatus = statusFilter.value;

    requestLists.forEach(list => {
      const affiliation = list.querySelector('.request_list_affiliation').textContent;
      const article = list.querySelector('.request_list_article').textContent;
      const status = list.querySelector('.request_list_status').textContent;

      const affiliationMatch = selectedAffiliation === "" || affiliation.includes(selectedAffiliation);
      const articleMatch = selectedArticle === "" || article.includes(selectedArticle);
      const statusMatch = selectedStatus === "" || status.includes(selectedStatus);

      if (affiliationMatch && articleMatch && statusMatch) {
        list.style.display = "";
      } else {
        list.style.display = "none";
      }
    });
  };

  affiliationFilter.addEventListener('change', filterRequests);
  articleFilter.addEventListener('change', filterRequests);
  statusFilter.addEventListener('change', filterRequests);
  
  filterRequests();
});