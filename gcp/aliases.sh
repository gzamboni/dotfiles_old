create_gcp_secret() {
	gcloud secrets create "$1" --replication-policy=automatic --data-file="$2"
}

create_gcp_secret_if_not_exists() {
	if ! gcloud secrets describe "$1" >/dev/null 2>&1; then
		create_gcp_secret "$1" "$2"
	fi
}

get_gcp_secret() {
	gcloud secrets versions access latest --secret="$1"
}

list_gcp_secrets() {
	gcloud secrets list
}

remove_gcp_secret() {
	gcloud secrets delete "$1"
}

update_gcp_secret() {
	gcloud secrets versions add "$1" --data-file="$2"
}
