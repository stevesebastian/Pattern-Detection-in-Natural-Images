function cT = computeThresholdInBin(binIndex, expTypeStr, targetTypeStr, subjectStr, bBootstrap)


% Load in subject experiment file
load(['./experiment_files/subject_out/' expTypeStr '/' targetTypeStr '/' subjectStr '.mat']);

expBinIndex = find(SubjectExpFile.binIndex(:,1) == binIndex(1) & SubjectExpFile.binIndex(:,2) == binIndex(2) & SubjectExpFile.binIndex(:,3) == binIndex(3));
expLvls    = SubjectExpFile.targetAmplitude(:,:,1,expBinIndex);
expCorrect = SubjectExpFile.correct(:,:,1,expBinIndex);

nTrials = size(expCorrect, 1);

targetLvls = SubjectExpFile.targetAmplitude(1,:,1,expBinIndex);

[cT, b] = analysis.fitPsychometric(0.01, 2, SubjectExpFile.targetAmplitude(:,:,1,expBinIndex), SubjectExpFile.correct(:,:,1,expBinIndex));

%% Figure properties
figure; hold on; 
ylim([0.5 1]);
xLimFactor = -1*diff(targetLvls);
xlim([targetLvls(end)-xLimFactor(1), targetLvls(1)+xLimFactor(1)]);
axis square; box off;
set(gca, 'FontSize', 20);
set(gca,'TickDir','out')
set(gcf,'color','w');
yLabelVal = 0.5:0.1:1;
set(gca, 'YTick', yLabelVal);
set(gca,'YTickLabel',sprintf('%1.1f\n',yLabelVal));
xLabelVal = targetLvls;
set(gca, 'XTick', fliplr(xLabelVal));
set(gca,'XTickLabel',sprintf('%.3f\n',fliplr(xLabelVal)));
x = 0:0.0001:(targetLvls(1)+0.2);
y =  normcdf(0.5.*(x./cT).^b);
plot(x, y, 'k-', 'LineWidth', 2);
xlabel('Target Amplitude');
ylabel('Proportion Correct');
%% Fit psychometric function
if(bBootstrap)
   nBootItr = 1000;
   for iBoot= 1:nBootItr
       correctBoot = datasample(expCorrect, nTrials, 'Replace', true);
       percentCorrect(:,iBoot) = mean(correctBoot);
   end
   meanPc = mean(percentCorrect,2);
   stdPc = std(percentCorrect, 0, 2);
   errorbar(targetLvls, meanPc, stdPc, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'auto', 'LineWidth', 2);
else
    percentCorrect = mean(expCorrect);
    plot(targetLvls, percentCorrect, 'o', 'MarkerSize', 10, 'LineWidth', 2);
end


