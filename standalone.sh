#! /bin/bash
mkdir -p ${folder}
cd ${folder}
if [ "${prov}" = False ] ; then
    export port_prov=False
fi


git clone https://github.com/mhnkrm/warriorframework.git
repo project init -u testcase-manifests t900-1.0
repo project sync
sed -i s"|warriorframework==4.4.0|${WORKSPACE}/${folder}/warriorframework/warriorframework-4.4.0-py3-none-any.whl|" ${WORKSPACE}/${folder}/test_framework/warrior-keywords/1finity/conf/warrior-requirements.pip
sed -i s"|output_file_obj.write(stamp + ' ' + type + ':' + job_obj.name + ' # ' + line)|output_file_obj.write(line) if 'Warrior' in job_obj.name else output_file_obj.write(job_obj.name + ' # ' + line)|" ${WORKSPACE}/${folder}/test_framework/network-topology/bin/exec-job-tree.py
cd ${WORKSPACE}/${folder}/test_framework

card=$(python -c 'import os,re;job_url=os.getenv("JOB_URL");print(re.findall(r"(P9.*?)/job/",job_url)[0])') 
echo $card



