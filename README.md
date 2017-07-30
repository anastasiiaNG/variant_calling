# variant_calling
Epam_project

Human genome variations analysis — 2 

A. Gainullina1, D. Kondinskaya2, E. Kupryashova3, G. Zakharov4,5

1 Peter the Great St. Petersburg Polytechnic University, St. Petersburg, Russia, 195251
2 St. Petersburg State University, St. Petersburg, Russia, 199034
3 Bioinformatics Institute, St. Petersburg, Russia, 197342
4 Epam Systems, Lifescience department, St. Petersburg, Russia, 196084 
5 Pavlov Institute of Physiology, Russian Academy of Sciences, St. Petersburg, Russia, 199034

anastasiia.gainullina@gmail.com
d.kondinskaia@gmail.com
eekupr@mail.ru
gennadii_zakharov@epam.com

Cardiomyopathies are a heterogeneous group of diseases that are associated with functional disturbances of heart muscle. Even though genetic predisposition is frequently observed in patients' anamnesis, a whole set of genes responsible for cardiomyopathy emergence is not determined yet.
46 target genes important in the research of inherited cardiomyopathies were sequenced by TruSight Cardiomyopathy Illumina panel. The data was obtained from 3 families of 3-4 members with at least one member affected by the disease. 
Quality control analysis of input data was made by FastQC. Data pre-processing of raw sequences included trimming of adapters with Trimmomatic and mapping the reads to reference genomes b37 and hg38 with BWA. Variant discovery was implemented on analysis-ready reads by means of GATK. ExAC database was used to cut off mutations with population frequency exceeding 10%. Mutations with unknown ExAC score were considered as potentially pathogenic. Variant annotation of discovered SNPs and InDels was performed with SNPEff and Annovar tools with use of various reference databases. Pathogenicity evaluation for unannotated variants was based on scores provided by prediction tools PolyPhen2 and MutationAssesor. Mutations in splice sites were extracted into a separate file and transformed into an appropriate format for manual analysis in HumanSpliceFinder since all investigated spice analysis tools don’t provide any suitable API. 
Mutations found and described by the proposed variant calling pipeline are sorted into three lists due to their low, moderate or high predicted pathogenic effect. This information could be considered for a proper choice of a treatment course or preventive therapy.


