library(tidyverse)
library(arrow)
library(here)

# we're going to _lightly_ preprocess the CSV downlods from
# usaspending.gov in order to store them in a more efficient format on
# the 360 google drive

# https://www.usaspending.gov/download_center/award_data_archive
dir.create(here("data", "contracts", "usa", "unzipped"), recursive = TRUE,
  showWarnings = FALSE)

# unzip files (~ 72 GB unzipped as of aug 2022)
list.files(
  here("data", "contracts", "usa"), pattern = glob2rx("*.zip"),
  full.names = T) %>%
  walk(unzip,
    exdir = here("data", "contracts", "usa", "unzipped"))

schema <- schema(
  contract_transaction_unique_key = string(),
  contract_award_unique_key = string(),
  award_id_piid = string(),
  modification_number = string(),
  transaction_number = string(),
  parent_award_agency_id = string(),
  parent_award_agency_name = string(),
  parent_award_id_piid = string(),
  parent_award_modification_number = string(),
  federal_action_obligation = float32(),
  total_dollars_obligated = float32(),
  base_and_exercised_options_value = float32(),
  current_total_value_of_award = float32(),
  base_and_all_options_value = float32(),
  potential_total_value_of_award = float32(),
  disaster_emergency_fund_codes_for_overall_award = string(),
  `outlayed_amount_funded_by_COVID-19_supplementals_for_overall_aw` = float32(),
  `obligated_amount_funded_by_COVID-19_supplementals_for_overall_a` = float32(),
  action_date = date32(),
  action_date_fiscal_year = uint16(),
  period_of_performance_start_date = string(),
  period_of_performance_current_end_date = string(),
  period_of_performance_potential_end_date = string(),
  ordering_period_end_date = date32(),
  solicitation_date = date32(),
  awarding_agency_code = string(),
  awarding_agency_name = string(),
  awarding_sub_agency_code = string(),
  awarding_sub_agency_name = string(),
  awarding_office_code = string(),
  awarding_office_name = string(),
  funding_agency_code = string(),
  funding_agency_name = string(),
  funding_sub_agency_code = string(),
  funding_sub_agency_name = string(),
  funding_office_code = string(),
  funding_office_name = string(),
  treasury_accounts_funding_this_award = string(),
  federal_accounts_funding_this_award = string(),
  object_classes_funding_this_award = string(),
  program_activities_funding_this_award = string(),
  foreign_funding = string(),
  foreign_funding_description = string(),
  sam_exception = string(),
  sam_exception_description = string(),
  recipient_uei = string(),
  recipient_duns = string(),
  recipient_name = string(),
  recipient_doing_business_as_name = string(),
  cage_code = string(),
  recipient_parent_uei = string(),
  recipient_parent_duns = string(),
  recipient_parent_name = string(),
  recipient_country_code = string(),
  recipient_country_name = string(),
  recipient_address_line_1 = string(),
  recipient_address_line_2 = string(),
  recipient_city_name = string(),
  recipient_county_name = string(),
  recipient_state_code = string(),
  recipient_state_name = string(),
  recipient_zip_4_code = string(),
  recipient_congressional_district = string(),
  recipient_phone_number = string(),
  recipient_fax_number = string(),
  primary_place_of_performance_country_code = string(),
  primary_place_of_performance_country_name = string(),
  primary_place_of_performance_city_name = string(),
  primary_place_of_performance_county_name = string(),
  primary_place_of_performance_state_code = string(),
  primary_place_of_performance_state_name = string(),
  primary_place_of_performance_zip_4 = string(),
  primary_place_of_performance_congressional_district = string(),
  award_or_idv_flag = string(),
  award_type_code = string(),
  award_type = string(),
  idv_type_code = string(),
  idv_type = string(),
  multiple_or_single_award_idv_code = string(),
  multiple_or_single_award_idv = string(),
  type_of_idc_code = string(),
  type_of_idc = string(),
  type_of_contract_pricing_code = string(),
  type_of_contract_pricing = string(),
  award_description = string(),
  action_type_code = string(),
  action_type = string(),
  solicitation_identifier = string(),
  number_of_actions = string(),
  inherently_governmental_functions = string(),
  inherently_governmental_functions_description = string(),
  product_or_service_code = string(),
  product_or_service_code_description = string(),
  contract_bundling_code = string(),
  contract_bundling = string(),
  dod_claimant_program_code = string(),
  dod_claimant_program_description = string(),
  naics_code = string(),
  naics_description = string(),
  recovered_materials_sustainability_code = string(),
  recovered_materials_sustainability = string(),
  domestic_or_foreign_entity_code = string(),
  domestic_or_foreign_entity = string(),
  dod_acquisition_program_code = string(),
  dod_acquisition_program_description = string(),
  information_technology_commercial_item_category_code = string(),
  information_technology_commercial_item_category = string(),
  epa_designated_product_code = string(),
  epa_designated_product = string(),
  country_of_product_or_service_origin_code = string(),
  country_of_product_or_service_origin = string(),
  place_of_manufacture_code = string(),
  place_of_manufacture = string(),
  subcontracting_plan_code = string(),
  subcontracting_plan = string(),
  extent_competed_code = string(),
  extent_competed = string(),
  solicitation_procedures_code = string(),
  solicitation_procedures = string(),
  type_of_set_aside_code = string(),
  type_of_set_aside = string(),
  evaluated_preference_code = string(),
  evaluated_preference = string(),
  research_code = string(),
  research = string(),
  fair_opportunity_limited_sources_code = string(),
  fair_opportunity_limited_sources = string(),
  other_than_full_and_open_competition_code = string(),
  other_than_full_and_open_competition = string(),
  number_of_offers_received = string(),
  commercial_item_acquisition_procedures_code = string(),
  commercial_item_acquisition_procedures = string(),
  small_business_competitiveness_demonstration_program = string(),
  simplified_procedures_for_certain_commercial_items_code = string(),
  simplified_procedures_for_certain_commercial_items = string(),
  a76_fair_act_action_code = string(),
  a76_fair_act_action = string(),
  fed_biz_opps_code = string(),
  fed_biz_opps = string(),
  local_area_set_aside_code = string(),
  local_area_set_aside = string(),
  price_evaluation_adjustment_preference_percent_difference = float32(),
  clinger_cohen_act_planning_code = string(),
  clinger_cohen_act_planning = string(),
  materials_supplies_articles_equipment_code = string(),
  materials_supplies_articles_equipment = string(),
  labor_standards_code = string(),
  labor_standards = string(),
  construction_wage_rate_requirements_code = string(),
  construction_wage_rate_requirements = string(),
  interagency_contracting_authority_code = string(),
  interagency_contracting_authority = string(),
  other_statutory_authority = string(),
  program_acronym = string(),
  parent_award_type_code = string(),
  parent_award_type = string(),
  parent_award_single_or_multiple_code = string(),
  parent_award_single_or_multiple = string(),
  major_program = string(),
  national_interest_action_code = string(),
  national_interest_action = string(),
  cost_or_pricing_data_code = string(),
  cost_or_pricing_data = string(),
  cost_accounting_standards_clause_code = string(),
  cost_accounting_standards_clause = string(),
  government_furnished_property_code = string(),
  government_furnished_property = string(),
  sea_transportation_code = string(),
  sea_transportation = string(),
  undefinitized_action_code = string(),
  undefinitized_action = string(),
  consolidated_contract_code = string(),
  consolidated_contract = string(),
  performance_based_service_acquisition_code = string(),
  performance_based_service_acquisition = string(),
  multi_year_contract_code = string(),
  multi_year_contract = string(),
  contract_financing_code = string(),
  contract_financing = string(),
  purchase_card_as_payment_method_code = string(),
  purchase_card_as_payment_method = string(),
  contingency_humanitarian_or_peacekeeping_operation_code = string(),
  contingency_humanitarian_or_peacekeeping_operation = string(),
  alaskan_native_corporation_owned_firm = string(),
  american_indian_owned_business = string(),
  indian_tribe_federally_recognized = string(),
  native_hawaiian_organization_owned_firm = string(),
  tribally_owned_firm = string(),
  veteran_owned_business = string(),
  service_disabled_veteran_owned_business = string(),
  woman_owned_business = string(),
  women_owned_small_business = string(),
  economically_disadvantaged_women_owned_small_business = string(),
  joint_venture_women_owned_small_business = string(),
  joint_venture_economic_disadvantaged_women_owned_small_bus = string(),
  minority_owned_business = string(),
  subcontinent_asian_asian_indian_american_owned_business = string(),
  asian_pacific_american_owned_business = string(),
  black_american_owned_business = string(),
  hispanic_american_owned_business = string(),
  native_american_owned_business = string(),
  other_minority_owned_business = string(),
  contracting_officers_determination_of_business_size = string(),
  contracting_officers_determination_of_business_size_code = string(),
  emerging_small_business = string(),
  community_developed_corporation_owned_firm = string(),
  labor_surplus_area_firm = string(),
  us_federal_government = string(),
  federally_funded_research_and_development_corp = string(),
  federal_agency = string(),
  us_state_government = string(),
  us_local_government = string(),
  city_local_government = string(),
  county_local_government = string(),
  inter_municipal_local_government = string(),
  local_government_owned = string(),
  municipality_local_government = string(),
  school_district_local_government = string(),
  township_local_government = string(),
  us_tribal_government = string(),
  foreign_government = string(),
  organizational_type = string(),
  corporate_entity_not_tax_exempt = string(),
  corporate_entity_tax_exempt = string(),
  partnership_or_limited_liability_partnership = string(),
  sole_proprietorship = string(),
  small_agricultural_cooperative = string(),
  international_organization = string(),
  us_government_entity = string(),
  community_development_corporation = string(),
  domestic_shelter = string(),
  educational_institution = string(),
  foundation = string(),
  hospital_flag = string(),
  manufacturer_of_goods = string(),
  veterinary_hospital = string(),
  hispanic_servicing_institution = string(),
  receives_contracts = string(),
  receives_financial_assistance = string(),
  receives_contracts_and_financial_assistance = string(),
  airport_authority = string(),
  council_of_governments = string(),
  housing_authorities_public_tribal = string(),
  interstate_entity = string(),
  planning_commission = string(),
  port_authority = string(),
  transit_authority = string(),
  subchapter_scorporation = string(),
  limited_liability_corporation = string(),
  foreign_owned = string(),
  for_profit_organization = string(),
  nonprofit_organization = string(),
  other_not_for_profit_organization = string(),
  the_ability_one_program = string(),
  private_university_or_college = string(),
  state_controlled_institution_of_higher_learning = string(),
  `1862_land_grant_college` = string(),
  `1890_land_grant_college` = string(),
  `1994_land_grant_college` = string(),
  minority_institution = string(),
  historically_black_college = string(),
  tribal_college = string(),
  alaskan_native_servicing_institution = string(),
  native_hawaiian_servicing_institution = string(),
  school_of_forestry = string(),
  veterinary_college = string(),
  dot_certified_disadvantage = string(),
  self_certified_small_disadvantaged_business = string(),
  small_disadvantaged_business = string(),
  c8a_program_participant = string(),
  historically_underutilized_business_zone_hubzone_firm = string(),
  sba_certified_8a_joint_venture = string(),
  highly_compensated_officer_1_name = string(),
  highly_compensated_officer_1_amount = float32(),
  highly_compensated_officer_2_name = string(),
  highly_compensated_officer_2_amount = float32(),
  highly_compensated_officer_3_name = string(),
  highly_compensated_officer_3_amount = float32(),
  highly_compensated_officer_4_name = string(),
  highly_compensated_officer_4_amount = float32(),
  highly_compensated_officer_5_name = string(),
  highly_compensated_officer_5_amount = float32(),
  usaspending_permalink = string(),
  last_modified_date = string())

# create an arrow dataset of all the csvs, then write out to parquet file
# (this will take a ~while~)
here("data", "contracts", "usa", "unzipped") %>%
  open_dataset(format = "csv", newlines_in_values = TRUE, schema = schema,
    skip_rows = 1, column_names = names(schema)) ->
all_data

# write it out
all_data %>%
  write_dataset(
    here("data", "contracts", "usa", "us-dod-contracts-all.parquet"),
    format = "parquet")