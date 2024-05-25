import Foundation

struct HomeMockResponse {
    static var json = """
{
  "paging": {
    "total": 100
  },
  "results": [
    {
      "id": "123",
      "title": "Motorola 34",
      "price": 1999.99,
      "thumbnail": "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg"
    },
    {
      "id": "456",
      "title": "iPhone 15",
      "price": 3999.99,
      "thumbnail": "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg"
    }
  ]
}
"""

    static var emptyResponse = """
{
  "paging": {
    "total": 0
  },
  "results": []
}
"""
}
