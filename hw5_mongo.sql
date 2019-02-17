--1
db.tags.count()
--2
db.tags.find({name: 'woman'}).count()
--3
db.tags.aggregate([{$group:{_id: "$name", tag_count: {$sum:1}}},{$sort:{tag_count: -1}},{$limit: 3}])
