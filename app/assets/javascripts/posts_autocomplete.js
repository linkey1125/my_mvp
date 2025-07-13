document.addEventListener('DOMContentLoaded', () => {
  const input = document.getElementById('search-keyword');
  const list = document.getElementById('autocomplete-list');

  if (!input || !list) return; // もし要素がなければ処理中断

  input.addEventListener('input', () => {
    const query = input.value.trim();
    if (query.length < 2) {
      list.style.display = 'none';
      list.innerHTML = '';
      return;
    }

    fetch(`/posts/autocomplete?q=${encodeURIComponent(query)}`)
      .then(res => res.json())
      .then(data => {
        list.innerHTML = '';
        if (data.length === 0) {
          list.style.display = 'none';
          return;
        }
        data.forEach(item => {
          const li = document.createElement('li');
          li.textContent = item;
          li.className = "px-3 py-2 cursor-pointer hover:bg-gray-200";
          li.addEventListener('click', () => {
            input.value = item;
            list.style.display = 'none';
            list.innerHTML = '';
          });
          list.appendChild(li);
        });
        list.style.display = 'block';
      })
      .catch(() => {
        // エラー時は候補を非表示に
        list.style.display = 'none';
        list.innerHTML = '';
      });
  });

  document.addEventListener('click', (e) => {
    if (e.target !== input) {
      list.style.display = 'none';
    }
  });
});
