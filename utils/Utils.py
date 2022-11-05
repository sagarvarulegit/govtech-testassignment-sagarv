import JSONLibrary
import JSONLibrary as jc
import datetime
import os


def pwd():
    s = os.getcwd()
    return s


def _variable(birthdate):
    age = datetime.date.today().year - int(birthdate[-4:])
    variable = 0
    if age <= 18:
        variable = 1
    elif 18 < age <= 35:
        variable = 0.8
    elif 35 < age <= 50:
        variable = 0.5
    elif 50 < age <= 75:
        variable = 0.367
    elif age >= 76:
        variable = 0.05
    else:
        raise (ValueError + "Value not Found")

    return round(variable, 2)


def _gender_bonus(gender):
    bonus = 0
    if gender == 'M':
        bonus = 0
    elif gender == 'F':
        bonus = 500
    else:
        raise (ValueError + "Value not found")
    return round(float(bonus), 2)


def validate_tax_relief(resp):
    """ This functions Validates AC: US4_AC3,US4_AC4,US4_AC5
    ie: AC4 - Rounding to 2 decimals
    AC5 - Computed Tax is in between 0.00 and 50.00 then Final Tax relief
    amount = 50.00
    """
    data = jc.JSONLibrary.load_json_from_file("./test-data/verify_tax_relief.json")
    resp_json = jc.JSONLibrary.convert_string_to_json(resp)
    for i in resp_json:
        for d in data:
            if i["name"] == d["name"]:
                v_salary = round(float(d["salary"]), 2)
                v_tax_paid = round(float(d["tax"]), 2)
                calculated_tax = (
                        ((v_salary - v_tax_paid) * _variable(
                            d["birthday"])) + _gender_bonus(d["gender"]))

                if 0 < round(calculated_tax, 2) < 50.00:
                    calculated_tax = 50.00

                assert float(i["relief"]) == calculated_tax
