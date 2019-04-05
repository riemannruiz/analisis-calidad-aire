function [mean_data,ratio_data]=mean_ratio_by_weeks(data,num_week)

    for c = 1:size(data,2)
        for k=1:52/num_week
            temp = data{c}(:,[num_week*(k-1)+1:num_week*k , (num_week*(k-1)+1:num_week*k)+52]);
            tmp1(:,k) = nanmean(data{c}(:,[num_week*(k-1)+1:num_week*k , (num_week*(k-1)+1:num_week*k)+52]),2);
        end
        tmp1 = tmp1(:);
        mean_week1(:,c)= tmp1;

        % Calculo de los cambios porcentuales de los promedios
        tmp1 = [tmp1;tmp1(1)];
        r_week1(:,c) = (tmp1(2:end)./tmp1(1:end-1))-1;
        clear tmp1
    end
    mean_data = mean_week1;
    ratio_data = r_week1;
