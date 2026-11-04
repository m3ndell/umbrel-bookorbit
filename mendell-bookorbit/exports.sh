#!/bin/bash
# Umbrel provides derive_entropy and app_entropy_identifier when sourcing this file.
# Distinct, stable keys survive container updates without public default secrets.
export APP_MENDELL_BOOKORBIT_JWT_SECRET="$(derive_entropy "${app_entropy_identifier}-JWT_SECRET")"
export APP_MENDELL_BOOKORBIT_PODCAST_KEY="$(derive_entropy "${app_entropy_identifier}-PODCAST_KEY")"
export APP_MENDELL_BOOKORBIT_EMAIL_KEY="$(derive_entropy "${app_entropy_identifier}-EMAIL_KEY")"
export APP_MENDELL_BOOKORBIT_MIGRATION_KEY="$(derive_entropy "${app_entropy_identifier}-MIGRATION_KEY")"
export APP_MENDELL_BOOKORBIT_REQUEST_KEY="$(derive_entropy "${app_entropy_identifier}-REQUEST_KEY")"
