mkdir -p ${folder}
cd ${folder}
if [ "${prov}" = False ] ; then
    export port_prov=False
fi

git clone https://github.com/mhnkrm/warriorframework.git
repo project init -u testcase-manifests t900-1.0
repo project sync
sed -i s"|warriorframework==4.4.0|${WORKSPACE}/${folder}/warriorframework/warriorframework-4.4.0-py3-none-any.whl|" ${WORKSPACE}/${folder}/test_framework/warrior-keywords/1finity/conf/warrior-requirements.pip
sed -i s"|output_file_obj.write(stamp + ' ' + type + ':' + job_obj.name + ' # ' + line)|output_file_obj.write(line) if 'Warrior' in job_obj.name else output_file_obj.write(job_obj.name + ' # ' + line)|" ${WORKSPACE}/test_framework/network-topology/bin/exec-job-tree.py
cd ${WORKSPACE}/${folder}/test_framework
source ./fnc-init-test-env

tfwk-exec-test-agent --topology-type docker-single --test-engine Warrior --topology-tag-name NE1-main --define-attr-defaults image-path=/proj/artifacts/projects/1finity-tseries/1finity-tseries_latest/release/build.artifact/MACHINE.qemux86-64/IMAGE.fss-image-full-t900 --define-attr-defaults machine-name=qemux86-64,image-name=fss-image-full-t900,image-info-config-name=main-BDT9-T900 --add-instance NE1/main --test-engine-begin --setenv INTF_TYPE:netconf --test-engine-end -- ${job} || exit 0
