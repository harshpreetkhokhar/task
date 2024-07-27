data "newrelic_entity" "get-guid" {
    for_each = var.entity-name
  name= each.value
}

resource "newrelic_entity_tags" "entity" {
   for_each = data.newrelic_entity.get-guid
  guid = data.newrelic_entity.get-guid[each.key].guid
 
 dynamic "tag" {
   for_each = var.tag[each.key] 

   content {
     key = tag.key
     values = [tag.value]
   }
 }
 dynamic "tag" {
   for_each =var.tag-1
   content {
     key = "CT_MAPPING_ID"
     values = [tag.value]
   }
 }

}