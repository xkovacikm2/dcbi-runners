$ -> $('.table-responsive').DataTable({
  'order': []
  'columnDefs': [{
    'targets': 'no-sort'
    'orderable': false
  }]
  'responsive': true
})
