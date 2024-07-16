function profit() {
  const filterRequests = () => {
    const affiliationFilter = document.getElementById("affiliation_filter");
    const articleFilter = document.getElementById("article_filter");
    const statusFilter = document.getElementById("status_filter");
    const requestsList = document.getElementById("requests_list");

    const affiliation = affiliationFilter.value.toLowerCase();
    const article = articleFilter.value.toLowerCase();
    const status = statusFilter.value.toLowerCase();

    Array.from(requestsList.children).forEach(request => {
      const requestAffiliation = request.querySelector(".request_list_affiliation").textContent.toLowerCase();
      const requestArticle = request.querySelector(".request_list_article").textContent.toLowerCase();
      const requestStatus = request.querySelector(".request_list_status").textContent.toLowerCase();

      const matchesAffiliation = !affiliation || requestAffiliation.includes(affiliation);
      const matchesArticle = !article || requestArticle.includes(article);
      const matchesStatus = !status || requestStatus.includes(status);

      if (matchesAffiliation && matchesArticle && matchesStatus) {
        request.style.display = "";
      } else {
        request.style.display = "none";
      }
    });
  };

  const initFilter = () => {
    filterRequests();

    const affiliationFilter = document.getElementById("affiliation_filter");
    const articleFilter = document.getElementById("article_filter");
    const statusFilter = document.getElementById("status_filter");

    affiliationFilter.addEventListener("change", filterRequests);
    articleFilter.addEventListener("change", filterRequests);
    statusFilter.addEventListener("change", filterRequests);
  };

  document.addEventListener("turbo:load", initFilter);
  document.addEventListener("turbo:render", initFilter);
}

profit();