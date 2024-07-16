document.addEventListener('DOMContentLoaded', function() {
  const affiliationFilter = document.getElementById('affiliation_filter');
  const statusFilter = document.getElementById('status_filter');

  affiliationFilter.addEventListener('change', updateRequests);
  statusFilter.addEventListener('change', updateRequests);

  function updateRequests() {
    const affiliationId = affiliationFilter.value;
    const status = statusFilter.value;

    fetch(`/requests/filter?affiliation_id=${affiliationId}&status=${status}`)
      .then(response => response.json())
      .then(data => {
        const requestsBottom = document.querySelector('.requests_bottom');
        requestsBottom.innerHTML = '';

        data.forEach(request => {
          const requestElement = document.createElement('ul');
          requestElement.classList.add('request_input_lists');
          requestElement.innerHTML = `
            <li class="request_list_request_time">${request.request_time}</li>
            <li class="request_list_affiliation">${request.user.affiliation.name} / ${request.user.lastname}</li>
            <li class="request_list_article">${request.article.name}</li>
            <li class="request_list_quantity_s">${request.quantity}</li>
            <li class="request_list_status">${request.status}</li>
            <li class="request_list_response_user">${request.response_user ? request.response_user.lastname : ''}</li>
          `;
          requestsBottom.appendChild(requestElement);
        });
      })
      .catch(error => console.error('Fetch error:', error));
  }
});