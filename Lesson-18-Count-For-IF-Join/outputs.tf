// Print all details
output "created_iam_users_all" {
  value = aws_iam_user.users
}

//Print only ID of users
output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

//Print my Custom output list
output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
    "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

//Print My Custom output MAP
output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id // "AIDA4BML4STW22K74HQFF" : "vasya"
  }
}

// Print List of users with name 4 characters ONLY
output "custom_if_length" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 4
  ]
}

#===================================================================

// Print nice MAP of InstanceID: PublicIP
output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip // "i-0490f049844513179" = "99.79.58.22"
  }
}

output "server_all_list" {
  value = {
    for server in aws_instance.servers :
    server.id => [server.public_ip, server.public_dns] // i-0ce19c21ac9eaf15d = ["34.207.160.67","ec2-34-207-160-67.compute-1.amazonaws.com"]
  }
}

output "server_all_merge_from_server_vars" {
  value = {
    for server in aws_instance.servers :
    server.id => "${server.public_ip}, ${server.public_dns}" // "i-0ce19c21ac9eaf15d" = "34.207.160.67, ec2-34-207-160-67.compute-1.amazonaws.com"
    #server.id => join(",", server.public_ip, public_dns)
  }
}

/* Print all data output for all instances from resource aws_instance - servers
output "server_all_full" {
value = aws_instance.servers

}
*/
